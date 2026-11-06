local _, ns = ...
local A = {}
ns.Anim = A

-- ===================================================================
-- Animations shared by the windows:
--  * A.Window(f): fade + light zoom when the window opens (OnShow);
--    A.Show(f) / A.Hide(f) open / close it (fade + zoom out, then Hide).
--    Closing with Escape stays instant (UISpecialFrames calls Hide).
--  * A.FadeIn(f): short fade of a page (tab change).
--  * A.Height(f, h, onDone): smooth height change (tracker collapse).
-- Frames with secure children (tracker) are never hidden or resized in
-- combat: the change is then skipped.
-- ===================================================================
local OPEN, CLOSE, PAGE, RESIZE = 0.35, 0.28, 0.3, 0.4

local function Scale(group, from, to, dur)
    local s = group:CreateAnimation("Scale")
    if s.SetScaleFrom then s:SetScaleFrom(from, from); s:SetScaleTo(to, to)
    elseif s.SetFromScale then s:SetFromScale(from, from); s:SetToScale(to, to)
    else s:SetScale(to / from, to / from) end
    s:SetOrigin("CENTER", 0, 0)
    s:SetDuration(dur)
    s:SetSmoothing("OUT")
    return s
end

local function Alpha(group, from, to, dur, smoothing)
    local a = group:CreateAnimation("Alpha")
    a:SetFromAlpha(from); a:SetToAlpha(to)
    a:SetDuration(dur)
    a:SetSmoothing(smoothing or "OUT")
    return a
end

-- noZoom: fade only (large windows: the zoom shakes their many textures)
function A.Window(f, noZoom)
    if f.dqfIn then return f end
    f.dqfIn = f:CreateAnimationGroup()
    Alpha(f.dqfIn, 0, 1, OPEN, "IN_OUT")
    if not noZoom then pcall(Scale, f.dqfIn, 0.9, 1, OPEN) end
    f.dqfOut = f:CreateAnimationGroup()
    Alpha(f.dqfOut, 1, 0, CLOSE, "IN_OUT")
    if not noZoom then pcall(Scale, f.dqfOut, 1, 0.93, CLOSE) end
    f.dqfOut:SetScript("OnFinished", function()
        -- hiding a frame with secure children is forbidden in combat
        if f.dqfSecure and InCombatLockdown() then return end
        f:Hide()
    end)
    f:HookScript("OnShow", function()
        if f.dqfOut:IsPlaying() then f.dqfOut:Stop() end
        f.dqfIn:Stop()
        f.dqfIn:Play()
    end)
    return f
end

function A.Show(f)
    if f.dqfOut and f.dqfOut:IsPlaying() then f.dqfOut:Stop() end
    f:Show()
end

function A.Hide(f)
    if not f:IsShown() then return end
    if not f.dqfOut or (f.dqfSecure and InCombatLockdown()) then return f:Hide() end
    if f.dqfOut:IsPlaying() then return end
    f.dqfIn:Stop()
    f.dqfOut:Play()
end

function A.SetShown(f, show)
    if show then A.Show(f) else A.Hide(f) end
end

function A.FadeIn(f)
    if not f.dqfFade then
        f.dqfFade = f:CreateAnimationGroup()
        -- from half visible: a soft change of page, not a blink
        Alpha(f.dqfFade, 0.35, 1, PAGE, "IN_OUT")
    end
    f.dqfFade:Stop()
    f.dqfFade:Play()
end

-- Smooth height (ease out). Called again while running: new target.
local driver = CreateFrame("Frame")
local running = {}
driver:Hide()
driver:SetScript("OnUpdate", function(_, elapsed)
    for f, r in pairs(running) do
        if f.dqfSecure and InCombatLockdown() then
            running[f] = nil
        else
            r.t = r.t + elapsed
            local p = math.min(1, r.t / RESIZE)
            local e = p < 0.5 and 4 * p ^ 3 or 1 - (-2 * p + 2) ^ 3 / 2 -- ease in-out
            f:SetHeight(r.from + (r.to - r.from) * e)
            if p >= 1 then
                running[f] = nil
                if r.done then r.done() end
            end
        end
    end
    if not next(running) then driver:Hide() end
end)

function A.Height(f, h, onDone)
    local r = running[f]
    if r then
        if math.abs(r.to - h) > 0.5 then r.from, r.to, r.t = f:GetHeight(), h, 0 end
        if onDone then r.done = onDone end
        return
    end
    if math.abs(f:GetHeight() - h) <= 0.5 then
        if onDone then onDone() end
        return
    end
    if f.dqfSecure and InCombatLockdown() then return end
    running[f] = { from = f:GetHeight(), to = h, t = 0, done = onDone }
    driver:Show()
end

function A.IsResizing(f) return running[f] ~= nil end
