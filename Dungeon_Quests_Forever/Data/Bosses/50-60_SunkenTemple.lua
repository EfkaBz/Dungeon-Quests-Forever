local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("ST", {
    instance = 109,
    area = 1477,
    bosses = {
        { name = "Balcony Minibosses", npc = { 5716, 5712, 5717, 5714, 5715, 5713 }, level = "51-52", display = 6701,
          loot = { 10783, 10784, 10787, 10788, 10785, 10786, 20606, 20607, 20608 } },
        { name = "Atal'alarion", npc = 8580, level = "50", display = 7873,
          loot = { 10800, 10798, 10799 } },
        { name = "Spawn of Hakkar", npc = 5708, level = "51", display = 4065,
          loot = { 10801, 10802 } },
        { name = "Avatar of Hakkar", npc = 8443, level = "48", display = 8053,
          loot = { 12462, 10843, 10845, 10842, 10846, 10838, 10844 } },
        { name = "Jammal'an the Prophet", npc = 5710, level = "54", display = 6708,
          loot = { 10806, 10808, 10807 } },
        { name = "Ogom the Wretched", npc = 5711, level = "53", display = 6709,
          loot = { 10805, 10803, 10804 } },
        { name = "Dreamscythe", npc = 5721, level = "53", display = 7553,
          loot = { 12465, 12466, 12464, 10797, 12463, 12243, 10795, 10796 } },
        { name = "Weaver", npc = 5720, level = "51", display = 6375,
          loot = { 12465, 12466, 12464, 10797, 12463, 12243, 10795, 10796 } },
        { name = "Hazzas", npc = 5722, level = "53", display = 9584,
          loot = { 12465, 12466, 12464, 10797, 12463, 12243, 10795, 10796 } },
        { name = "Morphaz", npc = 5719, level = "52", display = 7975,
          loot = { 12465, 12466, 12464, 10797, 12463, 12243, 10795, 10796 } },
        { name = "Shade of Eranikus", npc = 5709, level = "55", display = 7806,
          loot = { 10847, 10833, 10829, 10836, 10835, 10837, 10828, 10454 } },
    },
    trash = { 10630, 10632, 10631, 10633, 10629, 10634, 10624, 10623, 10625, 10626, 10628, 10627, 10782, 10781, 10780, 16216, 15733 },
})
