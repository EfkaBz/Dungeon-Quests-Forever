local _, ns = ...
local P = {}
ns.Progress = P

local function Flagged(q)
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        return C_QuestLog.IsQuestFlaggedCompleted(q)
    end
    return IsQuestFlaggedCompleted and IsQuestFlaggedCompleted(q)
end

function P.LogIndex(q)
    local i = GetQuestLogIndexByID and GetQuestLogIndexByID(q)
    if i and i > 0 then return i end
end

-- Followers: quests that require q (built from Questie's prerequisites for
-- every guide quest). If a follower is done or in the log, q is done too.
local followers
local function Followers()
    if followers then return followers end
    if not (ns.Questie and ns.Questie.Prerequisites) then return {} end
    local t, any = {}, false
    for _, d in pairs(ns.dungeons) do
        for _, s in ipairs(d.steps) do
            for _, pre in ipairs(ns.Questie.Prerequisites(s.quest) or {}) do
                t[pre] = t[pre] or {}
                t[pre][s.quest] = true
                any = true
            end
        end
    end
    if any then followers = t end -- Questie may not be ready yet: retry later
    return t
end

-- Turned in (flagged by the server, or implied by a later quest of the chain)
function P.IsCompleted(q, depth)
    if Flagged(q) then return true end
    depth = depth or 0
    if depth > 6 then return false end
    for f in pairs(Followers()[q] or {}) do
        if P.LogIndex(f) or P.IsCompleted(f, depth + 1) then return true end
    end
    return false
end

function P.ObjectivesDone(q)
    local i = P.LogIndex(q)
    if not i then return false end
    if C_QuestLog and C_QuestLog.IsComplete then
        local ok, done = pcall(C_QuestLog.IsComplete, q)
        if ok and done then return true end
    end
    -- Classic: GetQuestLogTitle -> title, level, tag, isHeader, isCollapsed, isComplete, ...
    local isComplete = select(6, GetQuestLogTitle(i))
    if isComplete == 1 or isComplete == true then return true end
    -- fallback: every objective finished
    local n = GetNumQuestLeaderBoards(i) or 0
    if n == 0 then return false end
    for j = 1, n do
        if not select(3, GetQuestLogLeaderBoard(j, i)) then return false end
    end
    return true
end

-- Quest log objectives: { {text=, done=}, ... } or nil when not in log
function P.Objectives(q)
    local i = P.LogIndex(q)
    if not i then return end
    local t = {}
    for j = 1, GetNumQuestLeaderBoards(i) or 0 do
        local text, _, finished = GetQuestLogLeaderBoard(j, i)
        if text then t[#t + 1] = { text = text, done = finished } end
    end
    return t
end

-- 0 = nothing, 1 = in log, 2 = objectives done, 3 = turned in
function P.QuestState(q)
    if P.IsCompleted(q) then return 3 end
    if P.LogIndex(q) then return P.ObjectivesDone(q) and 2 or 1 end
    return 0
end

-- Automatic detection. A step is done when:
--  accept : quest in log or already turned in
--  do     : objectives complete or turned in
--  talk / turnin : quest turned in
function P.IsAutoDone(step)
    local st = P.QuestState(step.quest)
    if st == 3 then return true end
    if step.type == "accept" then return st >= 1 end
    if step.type == "do" then
        if st == 2 then return true end
        -- only one objective of the quest (e.g. one boss per Scarlet Monastery wing)
        if st == 1 and step.objIndex then
            local i = P.LogIndex(step.quest)
            local ok, _, _, finished = pcall(GetQuestLogLeaderBoard, step.objIndex, i)
            return ok and finished and true or false
        end
    end
    return false
end

local function Manual(key)
    DQF_DB.manual[key] = DQF_DB.manual[key] or {}
    return DQF_DB.manual[key]
end

-- value: true = forced done, false = forced not done (overrides auto), nil = auto
function P.SetManual(d, uid, value)
    Manual(d.key)[uid] = value
end

-- "Go back to this step" (pos = position in the filtered list)
function P.GoToStep(d, pos)
    local manual = Manual(d.key)
    for i, s in ipairs(d.list) do manual[s.uid] = i < pos end
end

-- A quest event releases "forced not done" overrides of that quest,
-- so automatic detection takes over again after going back.
function P.ReleaseQuest(questID)
    if not questID then return end
    for key, manual in pairs(DQF_DB.manual) do
        local d = ns.dungeons[key]
        if d then
            for _, s in ipairs(d.steps) do
                if s.quest == questID and manual[s.uid] == false then manual[s.uid] = nil end
            end
        end
    end
end

-- Full scan: drop every "unchecked by hand" override so all quests already
-- done (turned in, in the log, objectives complete) validate their steps.
function P.Scan(verbose)
    for _, manual in pairs(DQF_DB.manual) do
        for uid, v in pairs(manual) do
            if v == false then manual[uid] = nil end
        end
    end
    ns.Update(true)
    if verbose and ns.state then
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99DQF|r : " .. ns.L("%d/%d étapes déjà faites.", "%d/%d steps already done."))
            :format(ns.state.done, ns.state.total))
    end
end

-- Builds d.list (filtered steps) and returns done, total, current position
function P.Evaluate(d)
    local manual = Manual(d.key)
    local done, cur = 0, nil
    d.list = {}
    local faction = UnitFactionGroup("player")
    for _, s in ipairs(d.steps) do
      -- steps of the other faction are never shown (they cannot be done)
      if not s.faction or s.faction == faction then
        s.auto = P.IsAutoDone(s)
        -- a quest already turned in always validates its steps, even if they
        -- were unchecked by hand earlier
        if manual[s.uid] == false and P.IsCompleted(s.quest) then manual[s.uid] = nil end
        s.done = manual[s.uid] == true or (manual[s.uid] ~= false and s.auto)
        d.list[#d.list + 1] = s
        s.pos = #d.list
        if s.done then done = done + 1
        elseif not cur then cur = s.pos end
      end
    end
    return done, #d.list, cur
end
