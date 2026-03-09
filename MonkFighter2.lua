local addonName, ns = ...
ns = ns or {}

local ADDON = CreateFrame("Frame")
ns.ADDON = ADDON

local SPEC_WINDWALKER = 269
local SOUND_CHANNEL = "SFX"
local COMBO_RESET_TEXT = "Combo Broken!"
local COMBO_BREAKER_SOUND = "combo_breaker.ogg"
local COMBO_BREAKER_VISUAL_DURATION = 1.6
local COMBO_TRACKER_AURA_ID = 1249753
local FONT_PATH = "Fonts\\FRIZQT__.TTF"
local WHITE_TEXTURE = "Interface\\Buttons\\WHITE8X8"
local PREVIEW_SPELL_ID = 100780
local PREVIEW_COMBO_COUNT = 7
local DEFAULT_FRAME_POINT = {
    point = "CENTER",
    relativePoint = "CENTER",
    x = -320,
    y = -60,
}

local SOUND_LIBRARY = {
    { file = "sf2_cannon_spike.ogg", label = "Cannon Spike" },
    { file = "sf2_hadoken.ogg", label = "Hadoken" },
    { file = "sf2_hhs.ogg", label = "Hundred Hand Slap" },
    { file = "sf2_kyaku.ogg", label = "Rekku Kyaku" },
    { file = "sf2_sbk.ogg", label = "Spinning Bird Kick" },
    { file = "sf2_shoryuken.ogg", label = "Shoryuken" },
    { file = "sf2_sonicboom.ogg", label = "Sonic Boom" },
    { file = "sf2_spiral_arrow.ogg", label = "Spiral Arrow" },
    { file = "sf2_tatsu.ogg", label = "Tatsumaki Senpukyaku" },
    { file = "sf2_tiger.ogg", label = "Tiger" },
    { file = "sf3_raging_demon.ogg", label = "Raging Demon" },
    { file = "sf4_flash_kick.ogg", label = "Flash Kick" },
    { file = "sf4_psycho_crusher.ogg", label = "Psycho Crusher" },
}

local SOUND_LABELS = {}
for _, soundInfo in ipairs(SOUND_LIBRARY) do
    SOUND_LABELS[soundInfo.file] = soundInfo.label
end

local SPELL_CONFIGS = {
    [100780] = { order = 10, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_tiger.ogg" }, -- Tiger Palm
    [100784] = { order = 20, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_cannon_spike.ogg" }, -- Blackout Kick
    [101545] = { order = 30, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_spiral_arrow.ogg", variantNote = "Base mobility kick. Replaced by Slicing Winds when talented." }, -- Flying Serpent Kick
    [101546] = { order = 40, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_tatsu.ogg" }, -- Spinning Crane Kick
    [107428] = { order = 50, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf4_flash_kick.ogg", variantNote = "Base version. Can proc into Rushing Wind Kick." }, -- Rising Sun Kick
    [113656] = { order = 60, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_hhs.ogg" }, -- Fists of Fury
    [115008] = { order = 65, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf4_psycho_crusher.ogg", variantNote = "Movement talent that replaces Roll. Plays sounds, but does not affect Combo Strikes tracking." }, -- Chi Torpedo
    [115098] = { order = 70, soundEvent = "UNIT_SPELLCAST_SUCCEEDED" }, -- Chi Wave
    [116847] = { order = 80, soundEvent = "UNIT_SPELLCAST_SUCCEEDED" }, -- Rushing Jade Wind
    [117952] = { order = 90, soundEvent = "UNIT_SPELLCAST_SUCCEEDED" }, -- Crackling Jade Lightning
    [119381] = { order = 100, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_sbk.ogg", variantNote = "Utility spell. Plays sounds, but does not affect Combo Strikes tracking." }, -- Leg Sweep
    [152175] = { order = 110, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_shoryuken.ogg", variantNote = "Choice node with Strike of the Windlord." }, -- Whirling Dragon Punch
    [261947] = { order = 120, soundEvent = "UNIT_SPELLCAST_SUCCEEDED" }, -- Fist of the White Tiger
    [310454] = { order = 130, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", variantNote = "Legacy spell support. Not part of current Combo Strikes aura family." }, -- Weapons of Order
    [322101] = { order = 140, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", variantNote = "Legacy spell support. Not part of current Combo Strikes aura family." }, -- Expel Harm
    [322109] = { order = 150, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf3_raging_demon.ogg" }, -- Touch of Death
    [325216] = { order = 160, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", variantNote = "Legacy spell support. Not part of current Combo Strikes aura family." }, -- Bonedust Brew
    [392983] = { order = 170, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_sonicboom.ogg", variantNote = "Choice node with Whirling Dragon Punch." }, -- Strike of the Windlord
    [443028] = { order = 180, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", variantNote = "Combo Strikes-eligible Midnight Celestial Conduit." }, -- Celestial Conduit
    [467307] = { order = 190, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", defaultSound = "sf2_kyaku.ogg", variantNote = "Proc/variant of Rising Sun Kick." }, -- Rushing Wind Kick
    [1217413] = { order = 200, soundEvent = "UNIT_SPELLCAST_EMPOWER_START", defaultSound = "sf2_sbk.ogg", variantNote = "Empower spell that replaces Flying Serpent Kick when talented." }, -- Slicing Winds
    [1249625] = { order = 210, soundEvent = "UNIT_SPELLCAST_SUCCEEDED", variantNote = "Combo Strikes-eligible Zenith finisher." }, -- Zenith
}

local COMBO_TRACKED_SPELLS = {
    [100780] = true, -- Tiger Palm
    [100784] = true, -- Blackout Kick
    [101546] = true, -- Spinning Crane Kick
    [107428] = true, -- Rising Sun Kick
    [113656] = true, -- Fists of Fury
    [117952] = true, -- Crackling Jade Lightning
    [152175] = true, -- Whirling Dragon Punch
    [322109] = true, -- Touch of Death
    [392983] = true, -- Strike of the Windlord
    [443028] = true, -- Celestial Conduit
    [467307] = true, -- Rushing Wind Kick
    [1217413] = true, -- Slicing Winds
    [1249625] = true, -- Zenith
}

local exclamations = {
    { count = 201, text = "Unstoppable!" },
    { count = 111, text = "Galactic!" },
    { count = 101, text = "Crazy!" },
    { count = 91, text = "Uncanny!" },
    { count = 82, text = "Marvelous!" },
    { count = 75, text = "Mighty!" },
    { count = 69, text = "Nice..." },
    { count = 63, text = "Incredible!" },
    { count = 57, text = "Amazing!" },
    { count = 50, text = "Fantastic!" },
    { count = 43, text = "Stylish!" },
    { count = 37, text = "Excellent!" },
    { count = 31, text = "Viewtiful!" },
    { count = 26, text = "Wonderful!" },
    { count = 21, text = "Awesome!" },
    { count = 17, text = "Sweet!" },
    { count = 13, text = "Dude!" },
    { count = 7, text = "Good!" },
    { count = 5, text = "Cool!" },
    { count = 3, text = "Yes!" },
    { count = 1, text = "" },
}

local COMBO_STYLES = {
    default = {
        name = "Default",
        frameWidth = 268,
        frameHeight = 92,
        countSizeOffset = 0,
        iconSize = 48,
        iconPoint = { "LEFT", "self", "LEFT", 8, 0 },
        iconBorderColor = { 1, 1, 1, 0.14 },
        backgroundColor = { 0, 0, 0, 0 },
        edgeColor = { 0, 0, 0, 0 },
        labelText = "COMBO",
        labelSize = 13,
        labelColor = { 0.95, 0.82, 0.38 },
        labelPoint = { "BOTTOMLEFT", "icon", "TOPLEFT", 0, 2 },
        countColor = { 1, 0.92, 0.42 },
        countBrokenColor = { 1, 0.32, 0.32 },
        countPoint = { "LEFT", "icon", "RIGHT", 10, 8 },
        countShadowColor = { 0, 0, 0, 0.9 },
        countShadowOffset = { 2, -2 },
        exclamationSize = 16,
        exclamationColor = { 1, 0.96, 0.72 },
        exclamationBrokenColor = { 1, 0.42, 0.42 },
        exclamationPoint = { "TOPLEFT", "count", "BOTTOMLEFT", 0, -1 },
        exclamationPoint2 = { "RIGHT", "self", "RIGHT", -8, 0 },
        exclamationJustify = "LEFT",
        moveHintColor = { 0.96, 0.71, 0.15 },
        breakerTextColor = { 1, 0.96, 0.96 },
        breakerShadowColor = { 0.82, 0.08, 0.08, 0.95 },
        breakerSlashColor = { 0.82, 0.08, 0.08, 0.72 },
        breakerTextPoint = { "CENTER", "self", "CENTER", 0, -4 },
        breakerSlashAPoint = { "CENTER", "self", "CENTER", 8, 2 },
        breakerSlashASize = { 220, 6 },
        breakerSlashBPoint = { "CENTER", "self", "CENTER", 26, 12 },
        breakerSlashBSize = { 150, 3 },
    },
    sf2 = {
        name = "Street Fighter II",
        frameWidth = 348,
        frameHeight = 94,
        countSizeOffset = 6,
        iconSize = 38,
        iconPoint = { "LEFT", "self", "LEFT", 8, -2 },
        iconBorderColor = { 1, 0.84, 0.28, 0.34 },
        backgroundColor = { 0, 0, 0, 0 },
        edgeColor = { 0, 0, 0, 0 },
        labelText = "HIT COMBO",
        labelSize = 24,
        labelColor = { 0.98, 0.62, 0.12 },
        labelPoint = { "LEFT", "count", "RIGHT", 8, 5 },
        countColor = { 0.2, 0.74, 1 },
        countBrokenColor = { 1, 0.28, 0.28 },
        countPoint = { "TOPLEFT", "icon", "TOPRIGHT", 10, 6 },
        countShadowColor = { 0.86, 0.08, 0.14, 0.96 },
        countShadowOffset = { 3, -3 },
        exclamationSize = 20,
        exclamationColor = { 1, 0.34, 0.34 },
        exclamationBrokenColor = { 1, 0.85, 0.3 },
        exclamationPoint = { "TOPLEFT", "count", "BOTTOMLEFT", 0, -1 },
        exclamationPoint2 = { "RIGHT", "self", "RIGHT", -10, 0 },
        exclamationJustify = "LEFT",
        moveHintColor = { 1, 0.74, 0.18 },
        breakerTextColor = { 1, 0.97, 0.82 },
        breakerShadowColor = { 0.86, 0.08, 0.14, 0.98 },
        breakerSlashColor = { 0.86, 0.08, 0.14, 0.76 },
        breakerTextPoint = { "CENTER", "self", "CENTER", 0, -4 },
        breakerSlashAPoint = { "CENTER", "self", "CENTER", 14, 2 },
        breakerSlashASize = { 236, 6 },
        breakerSlashBPoint = { "CENTER", "self", "CENTER", 30, 12 },
        breakerSlashBSize = { 166, 3 },
    },
    sf3 = {
        name = "Street Fighter III",
        frameWidth = 344,
        frameHeight = 92,
        countSizeOffset = 4,
        iconSize = 38,
        iconPoint = { "LEFT", "self", "LEFT", 8, -2 },
        iconBorderColor = { 0.98, 0.64, 0.16, 0.3 },
        backgroundColor = { 0, 0, 0, 0 },
        edgeColor = { 0, 0, 0, 0 },
        labelText = "HIT COMBO",
        labelSize = 24,
        labelColor = { 0.97, 0.56, 0.1 },
        labelPoint = { "LEFT", "count", "RIGHT", 8, 4 },
        countColor = { 0.12, 0.92, 0.82 },
        countBrokenColor = { 1, 0.34, 0.34 },
        countPoint = { "TOPLEFT", "icon", "TOPRIGHT", 10, 5 },
        countShadowColor = { 0, 0, 0, 0.96 },
        countShadowOffset = { 2, -2 },
        exclamationSize = 19,
        exclamationColor = { 0.34, 0.96, 0.86 },
        exclamationBrokenColor = { 1, 0.72, 0.28 },
        exclamationPoint = { "TOPLEFT", "count", "BOTTOMLEFT", 0, -2 },
        exclamationPoint2 = { "RIGHT", "self", "RIGHT", -10, 0 },
        exclamationJustify = "LEFT",
        moveHintColor = { 0.97, 0.56, 0.1 },
        breakerTextColor = { 1, 0.96, 0.9 },
        breakerShadowColor = { 0.84, 0.18, 0.08, 0.96 },
        breakerSlashColor = { 0.84, 0.18, 0.08, 0.74 },
        breakerTextPoint = { "CENTER", "self", "CENTER", 0, -4 },
        breakerSlashAPoint = { "CENTER", "self", "CENTER", 14, 2 },
        breakerSlashASize = { 230, 6 },
        breakerSlashBPoint = { "CENTER", "self", "CENTER", 28, 11 },
        breakerSlashBSize = { 160, 3 },
    },
    sf4 = {
        name = "Street Fighter IV",
        frameWidth = 340,
        frameHeight = 90,
        countSizeOffset = 2,
        iconSize = 34,
        iconPoint = { "LEFT", "self", "LEFT", 8, -2 },
        iconBorderColor = { 0.7, 0.86, 1, 0.3 },
        backgroundColor = { 0, 0, 0, 0 },
        edgeColor = { 0, 0, 0, 0 },
        labelText = "HIT COMBO",
        labelSize = 23,
        labelColor = { 0.98, 0.98, 1 },
        labelPoint = { "LEFT", "count", "RIGHT", 8, 4 },
        countColor = { 0.95, 0.98, 1 },
        countBrokenColor = { 1, 0.42, 0.42 },
        countPoint = { "TOPLEFT", "icon", "TOPRIGHT", 10, 5 },
        countShadowColor = { 0.22, 0.24, 0.28, 0.98 },
        countShadowOffset = { 2, -2 },
        exclamationSize = 20,
        exclamationColor = { 0.3, 0.9, 1 },
        exclamationBrokenColor = { 1, 0.78, 0.3 },
        exclamationPoint = { "TOPLEFT", "count", "BOTTOMLEFT", 0, -2 },
        exclamationPoint2 = { "RIGHT", "self", "RIGHT", -10, 0 },
        exclamationJustify = "LEFT",
        moveHintColor = { 0.72, 0.88, 1 },
        breakerTextColor = { 1, 1, 1 },
        breakerShadowColor = { 0.26, 0.62, 0.9, 0.9 },
        breakerSlashColor = { 0.2, 0.72, 0.96, 0.5 },
        breakerTextPoint = { "CENTER", "self", "CENTER", 0, -4 },
        breakerSlashAPoint = { "CENTER", "self", "CENTER", 14, 2 },
        breakerSlashASize = { 224, 6 },
        breakerSlashBPoint = { "CENTER", "self", "CENTER", 28, 11 },
        breakerSlashBSize = { 156, 3 },
    },
    mvc3 = {
        name = "Marvel vs. Capcom 3",
        frameWidth = 334,
        frameHeight = 102,
        countSizeOffset = 12,
        iconSize = 34,
        iconPoint = { "RIGHT", "self", "RIGHT", -8, 0 },
        iconBorderColor = { 1, 0.85, 0.2, 0.4 },
        backgroundColor = { 0, 0, 0, 0 },
        edgeColor = { 0, 0, 0, 0 },
        labelText = "",
        labelSize = 14,
        labelColor = { 1, 1, 1 },
        labelPoint = { "TOPLEFT", "self", "TOPLEFT", 10, -10 },
        countColor = { 1, 0.78, 0.14 },
        countBrokenColor = { 1, 0.24, 0.24 },
        countPoint = { "LEFT", "self", "LEFT", 10, 0 },
        countShadowColor = { 0.88, 0.1, 0.1, 0.98 },
        countShadowOffset = { 4, -4 },
        suffixText = "HITS!",
        suffixSize = 23,
        suffixColor = { 1, 0.86, 0.24 },
        suffixPoint = { "LEFT", "count", "RIGHT", 8, -2 },
        suffixShadowColor = { 0.72, 0.14, 0.08, 0.96 },
        suffixShadowOffset = { 2, -2 },
        exclamationSize = 18,
        exclamationColor = { 1, 0.96, 0.82 },
        exclamationBrokenColor = { 1, 0.44, 0.44 },
        exclamationPoint = { "TOPLEFT", "count", "BOTTOMLEFT", 4, -2 },
        exclamationPoint2 = { "RIGHT", "icon", "LEFT", -10, 0 },
        exclamationJustify = "LEFT",
        moveHintColor = { 1, 0.82, 0.18 },
        breakerTextColor = { 1, 0.98, 0.9 },
        breakerShadowColor = { 0.92, 0.1, 0.1, 0.96 },
        breakerSlashColor = { 0.92, 0.1, 0.1, 0.78 },
    },
    ki = {
        name = "Killer Instinct",
        frameWidth = 320,
        frameHeight = 104,
        countSizeOffset = 8,
        iconSize = 34,
        iconPoint = { "LEFT", "self", "LEFT", 8, -4 },
        iconBorderColor = { 0.92, 0.18, 0.18, 0.38 },
        backgroundColor = { 0.03, 0.03, 0.03, 0.18 },
        edgeColor = { 0.7, 0.04, 0.04, 0.56 },
        labelText = "COMBO",
        labelSize = 18,
        labelColor = { 0.96, 0.96, 0.96 },
        labelPoint = { "TOPLEFT", "self", "TOPLEFT", 54, -10 },
        countColor = { 1, 1, 1 },
        countBrokenColor = { 1, 0.44, 0.44 },
        countPoint = { "TOPLEFT", "label", "BOTTOMLEFT", 24, -6 },
        countShadowColor = { 0.76, 0.08, 0.08, 0.98 },
        countShadowOffset = { 3, -3 },
        suffixText = "HITS",
        suffixSize = 16,
        suffixColor = { 1, 1, 1 },
        suffixPoint = { "LEFT", "count", "RIGHT", 8, -8 },
        suffixShadowColor = { 0.76, 0.08, 0.08, 0.9 },
        suffixShadowOffset = { 2, -2 },
        exclamationSize = 18,
        exclamationColor = { 1, 0.96, 0.56 },
        exclamationBrokenColor = { 1, 0.46, 0.46 },
        exclamationPoint = { "TOPLEFT", "count", "BOTTOMLEFT", -4, -2 },
        exclamationPoint2 = { "RIGHT", "self", "RIGHT", -10, 0 },
        exclamationJustify = "LEFT",
        moveHintColor = { 1, 0.34, 0.34 },
        breakerTextColor = { 1, 1, 1 },
        breakerShadowColor = { 0.88, 0.08, 0.08, 0.98 },
        breakerSlashColor = { 0.88, 0.08, 0.08, 0.84 },
        breakerTextPoint = { "CENTER", "self", "CENTER", 0, -2 },
        breakerSlashAPoint = { "CENTER", "self", "CENTER", 18, 4 },
        breakerSlashASize = { 250, 6 },
        breakerSlashBPoint = { "CENTER", "self", "CENTER", 34, 14 },
        breakerSlashBSize = { 176, 3 },
    },
}

local COMBO_STYLE_ORDER = { "default", "sf2", "sf3", "sf4", "mvc3", "ki" }

local defaults = {
    soundsEnabled = true,
    comboEnabled = true,
    persistCombo = true,
    persistHudHideDelay = 10,
    frameLocked = true,
    framePoint = DEFAULT_FRAME_POINT,
    soundMappings = {},
    comboStyle = "default",
    comboFontOverride = nil,
}

local state = {
    isWindwalker = false,
    comboCount = 0,
    lastSpellID = nil,
    lastExclamation = "",
    comboDisplayExpiresAt = nil,
    debugComboAura = false,
    lastAuraInstanceID = nil,
    lastAuraLabel = nil,
    lastComboAuraSummary = nil,
    comboBreakerExpiresAt = nil,
    previewMode = false,
    refreshingOptions = false,
    eventSpellIndex = {},
    optionRows = {},
    optionsCategory = nil,
}

local comboFrame
local optionsPanel
local GetComboText
local SetFrameLocked
local RefreshOptionsPanel

local function GetSharedMedia()
    if not LibStub then
        return nil
    end

    return LibStub("LibSharedMedia-3.0", true)
end

local function GetSharedMediaFontPath(fontName)
    if not fontName or fontName == "" then
        return nil
    end

    local media = GetSharedMedia()
    if not media or not media.Fetch then
        return nil
    end

    local ok, fontPath = pcall(media.Fetch, media, "font", fontName, true)
    if ok and fontPath and fontPath ~= "" then
        return fontPath
    end

    return nil
end

local function GetSharedMediaFontNames()
    local media = GetSharedMedia()
    if not media or not media.List then
        return nil
    end

    local fontNames = media:List("font")
    table.sort(fontNames)
    return fontNames
end

local function GetOrderedComboStyleKeys()
    return COMBO_STYLE_ORDER
end

local function GetTimeSafe()
    if GetTime then
        return GetTime()
    end

    return 0
end

local function CopyTable(source)
    if type(source) ~= "table" then
        return source
    end

    local copy = {}
    for key, value in pairs(source) do
        copy[key] = CopyTable(value)
    end

    return copy
end

local function GetComboFontSize(comboCount)
    if comboCount >= 120 then
        return 50
    elseif comboCount >= 100 then
        return 45
    elseif comboCount >= 80 then
        return 40
    elseif comboCount >= 60 then
        return 35
    elseif comboCount >= 40 then
        return 30
    elseif comboCount >= 20 then
        return 25
    elseif comboCount >= 10 then
        return 22
    end

    return 34
end

local function GetSpellNameSafe(spellID)
    if C_Spell and C_Spell.GetSpellName then
        return C_Spell.GetSpellName(spellID)
    end

    return GetSpellInfo(spellID)
end

local function GetConfiguredSpellName(spellID)
    return GetSpellNameSafe(spellID) or ("Spell " .. spellID)
end

local function GetSpellTextureSafe(spellID)
    if not spellID then
        return nil
    end

    if C_Spell and C_Spell.GetSpellTexture then
        local ok, icon = pcall(C_Spell.GetSpellTexture, spellID)
        if ok then
            return icon
        end
        return nil
    end

    local _, _, icon = GetSpellInfo(spellID)
    return icon
end

local function GetPlayerAuraDataBySpellIDSafe(spellID)
    if C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID then
        return C_UnitAuras.GetPlayerAuraBySpellID(spellID)
    end

    return nil
end

local function IsSpellKnownSafe(spellID)
    if IsSpellKnownOrOverridesKnown then
        return IsSpellKnownOrOverridesKnown(spellID)
    end

    if IsPlayerSpell then
        return IsPlayerSpell(spellID)
    end

    return false
end

local function IsWindwalker()
    local _, class = UnitClass("player")
    if class ~= "MONK" then
        return false
    end

    local specializationIndex = GetSpecialization()
    if not specializationIndex then
        return false
    end

    return GetSpecializationInfo(specializationIndex) == SPEC_WINDWALKER
end

local function EnsureDB()
    if type(MonkFighter2DB) ~= "table" then
        MonkFighter2DB = {}
    end

    for key, value in pairs(defaults) do
        if MonkFighter2DB[key] == nil then
            MonkFighter2DB[key] = CopyTable(value)
        end
    end

    if type(MonkFighter2DB.soundMappings) ~= "table" then
        MonkFighter2DB.soundMappings = {}
    end

    if type(MonkFighter2DB.framePoint) ~= "table" then
        MonkFighter2DB.framePoint = CopyTable(DEFAULT_FRAME_POINT)
    end

    if COMBO_STYLES[MonkFighter2DB.comboStyle] == nil then
        MonkFighter2DB.comboStyle = "default"
    end

    if MonkFighter2DB.comboFontOverride ~= nil and MonkFighter2DB.comboFontOverride == "" then
        MonkFighter2DB.comboFontOverride = nil
    end
end

local function GetComboStyleDefinition()
    return COMBO_STYLES[MonkFighter2DB.comboStyle] or COMBO_STYLES.default
end

local function ResolveRegionAnchor(anchorName)
    if anchorName == "self" then
        return comboFrame
    end

    return comboFrame and comboFrame[anchorName] or nil
end

local function SetRegionPoints(region, primaryPoint, secondaryPoint)
    region:ClearAllPoints()

    if primaryPoint then
        region:SetPoint(
            primaryPoint[1],
            ResolveRegionAnchor(primaryPoint[2]),
            primaryPoint[3],
            primaryPoint[4],
            primaryPoint[5]
        )
    end

    if secondaryPoint then
        region:SetPoint(
            secondaryPoint[1],
            ResolveRegionAnchor(secondaryPoint[2]),
            secondaryPoint[3],
            secondaryPoint[4],
            secondaryPoint[5]
        )
    end
end

local function PointReferencesAnchor(point, anchorName)
    return point and point[2] == anchorName
end

local function ApplyShadow(region, shadowColor, shadowOffset)
    if shadowColor then
        region:SetShadowColor(unpack(shadowColor))
    else
        region:SetShadowColor(0, 0, 0, 0)
    end

    if shadowOffset then
        region:SetShadowOffset(shadowOffset[1], shadowOffset[2])
    else
        region:SetShadowOffset(0, 0)
    end
end

local function SetTextureRotationSafe(textureRegion, radians)
    if textureRegion and textureRegion.SetRotation then
        textureRegion:SetRotation(radians)
    end
end

local function GetComboFontPath()
    return GetSharedMediaFontPath(MonkFighter2DB.comboFontOverride) or FONT_PATH
end

local function ApplyFont(region, size, flags, shadowColor, shadowOffset)
    region:SetFont(GetComboFontPath(), size, flags or "OUTLINE")
    ApplyShadow(region, shadowColor, shadowOffset)
end

local function GetStyleCountSize(style, comboCount)
    return math.max(18, GetComboFontSize(comboCount) + (style.countSizeOffset or 0))
end

local function IsComboBreakerActive()
    return state.comboBreakerExpiresAt and GetTimeSafe() < state.comboBreakerExpiresAt
end

local function GetDisplayComboCount()
    if state.previewMode and state.comboCount == 0 then
        return PREVIEW_COMBO_COUNT
    end

    return state.comboCount
end

local function GetDisplayExclamation()
    if state.lastExclamation ~= "" then
        return state.lastExclamation
    end

    if state.previewMode then
        return GetComboText(GetDisplayComboCount())
    end

    return ""
end

local function GetDisplaySpellID(spellID)
    return spellID or state.lastSpellID or (state.previewMode and PREVIEW_SPELL_ID) or nil
end

local function EnableComboPreview()
    state.previewMode = true
end

local function ClearComboPreview()
    state.previewMode = false
end

local function UnlockComboHUDForPreview()
    EnableComboPreview()
    SetFrameLocked(false)
end

local function BuildSoundPath(fileName)
    return string.format("Interface\\AddOns\\%s\\sounds\\%s", addonName, fileName)
end

local function GetSoundChoiceLabel(fileName)
    if fileName == nil then
        return "Default"
    end

    if fileName == false then
        return "None"
    end

    return SOUND_LABELS[fileName] or fileName
end

local function GetDefaultSoundLabel(spellID)
    local config = SPELL_CONFIGS[spellID]
    if not config or not config.defaultSound then
        return "Default (None)"
    end

    return string.format("Default (%s)", GetSoundChoiceLabel(config.defaultSound))
end

local function GetMappedSoundFile(spellID)
    local override = MonkFighter2DB.soundMappings[spellID]
    if override == false then
        return nil
    end

    if override then
        return override
    end

    local config = SPELL_CONFIGS[spellID]
    return config and config.defaultSound or nil
end

GetComboText = function(comboCount)
    for _, entry in ipairs(exclamations) do
        if comboCount >= entry.count then
            return entry.text
        end
    end

    return ""
end

local function DebugPrint(message)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cffd7a744MonkFighter2 debug:|r " .. message)
    end
end

local function GetAuraDebugLabel(auraData)
    if not auraData then
        return "none"
    end

    local auraName = auraData.name or "?"
    local icon = auraData.icon or auraData.iconFileID or "?"
    local instanceID = auraData.auraInstanceID or "?"
    local applications = auraData.applications or 0
    return string.format("%s | icon=%s | instance=%s | stacks=%s", auraName, tostring(icon), tostring(instanceID), tostring(applications))
end

local function GetActiveComboStrikeAuras()
    local activeAuras = {}

    if AuraUtil and AuraUtil.ForEachAura then
        AuraUtil.ForEachAura("player", "HELPFUL", nil, function(auraData)
            if auraData and auraData.name and auraData.name:find("^Combo Strikes:") then
                activeAuras[#activeAuras + 1] = auraData
            end
        end, true)
    end

    table.sort(activeAuras, function(leftAura, rightAura)
        local leftID = leftAura and leftAura.spellId or 0
        local rightID = rightAura and rightAura.spellId or 0
        return leftID < rightID
    end)

    return activeAuras
end

local function GetComboAuraSummary()
    local activeAuras = GetActiveComboStrikeAuras()
    if #activeAuras == 0 then
        return "none"
    end

    local parts = {}
    for _, auraData in ipairs(activeAuras) do
        parts[#parts + 1] = string.format(
            "%s (spellID=%s, instance=%s)",
            auraData.name or "?",
            tostring(auraData.spellId or "?"),
            tostring(auraData.auraInstanceID or "?")
        )
    end

    return table.concat(parts, " || ")
end

local function DebugReportComboAuraList(context)
    if not state.debugComboAura then
        return
    end

    local summary = GetComboAuraSummary()
    if summary ~= state.lastComboAuraSummary then
        DebugPrint(string.format("%s: combo aura list %s", context, summary))
        state.lastComboAuraSummary = summary
    end
end

local function DebugReportComboAura(context, spellID)
    if not state.debugComboAura then
        return
    end

    local auraData = GetPlayerAuraDataBySpellIDSafe(COMBO_TRACKER_AURA_ID)
    local auraLabel = GetAuraDebugLabel(auraData)

    if context == "cast" then
        local spellName = GetConfiguredSpellName(spellID)
        DebugPrint(string.format("%s: cast %s (%s) -> aura %s", context, spellName, tostring(spellID), auraLabel))
        return
    end

    if auraLabel ~= state.lastAuraLabel then
        DebugPrint(string.format("%s: aura %s", context, auraLabel))
        state.lastAuraLabel = auraLabel
        state.lastAuraInstanceID = auraData and auraData.auraInstanceID or nil
    end

    DebugReportComboAuraList(context)
end

local function SaveFramePosition()
    if not comboFrame then
        return
    end

    local point, _, relativePoint, x, y = comboFrame:GetPoint(1)
    MonkFighter2DB.framePoint.point = point or DEFAULT_FRAME_POINT.point
    MonkFighter2DB.framePoint.relativePoint = relativePoint or DEFAULT_FRAME_POINT.relativePoint
    MonkFighter2DB.framePoint.x = x or DEFAULT_FRAME_POINT.x
    MonkFighter2DB.framePoint.y = y or DEFAULT_FRAME_POINT.y
end

local function ApplyFramePosition()
    if not comboFrame then
        return
    end

    local framePoint = MonkFighter2DB.framePoint or DEFAULT_FRAME_POINT
    comboFrame:ClearAllPoints()
    comboFrame:SetPoint(
        framePoint.point or DEFAULT_FRAME_POINT.point,
        UIParent,
        framePoint.relativePoint or DEFAULT_FRAME_POINT.relativePoint,
        framePoint.x or DEFAULT_FRAME_POINT.x,
        framePoint.y or DEFAULT_FRAME_POINT.y
    )
end

local function UpdateFrameVisibility()
    if not comboFrame then
        return
    end

    local now = GetTimeSafe()
    local comboVisible = MonkFighter2DB.comboEnabled and (
        InCombatLockdown() or
        (
            MonkFighter2DB.persistCombo and
            state.comboCount > 0 and
            state.comboDisplayExpiresAt ~= nil and
            now < state.comboDisplayExpiresAt
        )
    )
    if not comboVisible and IsComboBreakerActive() then
        comboVisible = true
    end
    if not comboVisible and state.previewMode then
        comboVisible = true
    end

    local shouldShow = state.isWindwalker and (not MonkFighter2DB.frameLocked or comboVisible)
    comboFrame:SetShown(shouldShow)
    if comboFrame.moveHint then
        comboFrame.moveHint:SetShown(not MonkFighter2DB.frameLocked)
    end
end

local function ApplyComboTheme()
    if not comboFrame then
        return
    end

    local style = GetComboStyleDefinition()
    comboFrame:SetSize(style.frameWidth, style.frameHeight)
    comboFrame.bg:SetColorTexture(unpack(style.backgroundColor))
    comboFrame.edgeTop:SetColorTexture(unpack(style.edgeColor))
    comboFrame.icon:ClearAllPoints()
    comboFrame.count:ClearAllPoints()
    comboFrame.label:ClearAllPoints()
    comboFrame.suffix:ClearAllPoints()
    comboFrame.exclamation:ClearAllPoints()
    comboFrame.icon:SetSize(style.iconSize, style.iconSize)
    SetRegionPoints(comboFrame.icon, style.iconPoint)
    comboFrame.iconBorder:SetPoint("TOPLEFT", comboFrame.icon, "TOPLEFT", -2, 2)
    comboFrame.iconBorder:SetPoint("BOTTOMRIGHT", comboFrame.icon, "BOTTOMRIGHT", 2, -2)
    comboFrame.iconBorder:SetColorTexture(unpack(style.iconBorderColor))

    comboFrame.label:SetText(style.labelText or "")
    comboFrame.label:SetShown((style.labelText or "") ~= "")
    comboFrame.label:SetJustifyH("LEFT")
    ApplyFont(comboFrame.label, style.labelSize or 14, "OUTLINE", style.countShadowColor, { 1, -1 })
    comboFrame.label:SetTextColor(unpack(style.labelColor or { 1, 1, 1 }))

    local countDependsOnLabel = PointReferencesAnchor(style.countPoint, "label")
    local labelDependsOnCount = PointReferencesAnchor(style.labelPoint, "count")
    if countDependsOnLabel and not labelDependsOnCount then
        SetRegionPoints(comboFrame.label, style.labelPoint)
        SetRegionPoints(comboFrame.count, style.countPoint)
    else
        SetRegionPoints(comboFrame.count, style.countPoint)
        SetRegionPoints(comboFrame.label, style.labelPoint)
    end

    comboFrame.count:SetJustifyH("LEFT")
    ApplyFont(comboFrame.count, GetStyleCountSize(style, math.max(1, GetDisplayComboCount())), "OUTLINE", style.countShadowColor, style.countShadowOffset)

    comboFrame.suffix:SetText(style.suffixText or "")
    comboFrame.suffix:SetShown((style.suffixText or "") ~= "")
    if style.suffixText then
        SetRegionPoints(comboFrame.suffix, style.suffixPoint)
        comboFrame.suffix:SetJustifyH("LEFT")
        ApplyFont(comboFrame.suffix, style.suffixSize or 16, "OUTLINE", style.suffixShadowColor, style.suffixShadowOffset)
        comboFrame.suffix:SetTextColor(unpack(style.suffixColor or { 1, 1, 1 }))
    end

    SetRegionPoints(comboFrame.exclamation, style.exclamationPoint, style.exclamationPoint2)
    comboFrame.exclamation:SetJustifyH(style.exclamationJustify or "LEFT")
    ApplyFont(comboFrame.exclamation, style.exclamationSize or 16, "OUTLINE", style.countShadowColor, { 1, -1 })

    comboFrame.moveHint:SetPoint("TOP", comboFrame, "TOP", 0, -10)
    ApplyFont(comboFrame.moveHint, 11, "OUTLINE", nil, nil)
    comboFrame.moveHint:SetTextColor(unpack(style.moveHintColor or { 1, 0.82, 0.25 }))

    SetRegionPoints(comboFrame.breakerText, style.breakerTextPoint or { "CENTER", "self", "CENTER", 0, 0 })
    ApplyFont(comboFrame.breakerText, math.floor((style.exclamationSize or 16) * 1.5), "OUTLINE", style.breakerShadowColor, { 2, -2 })
    comboFrame.breakerText:SetTextColor(unpack(style.breakerTextColor or { 1, 1, 1 }))
    comboFrame.breakerSlashA:ClearAllPoints()
    comboFrame.breakerSlashB:ClearAllPoints()
    comboFrame.breakerSlashA:SetSize(unpack(style.breakerSlashASize or { 180, 8 }))
    comboFrame.breakerSlashB:SetSize(unpack(style.breakerSlashBSize or { 140, 4 }))
    SetRegionPoints(comboFrame.breakerSlashA, style.breakerSlashAPoint or { "CENTER", "self", "CENTER", 0, -2 })
    SetRegionPoints(comboFrame.breakerSlashB, style.breakerSlashBPoint or { "CENTER", "self", "CENTER", 14, 8 })
    comboFrame.breakerSlashA:SetColorTexture(unpack(style.breakerSlashColor or { 0.9, 0.12, 0.12, 0.72 }))
    comboFrame.breakerSlashB:SetColorTexture(unpack(style.breakerSlashColor or { 0.9, 0.12, 0.12, 0.72 }))
end

local function UpdateComboFrame(spellID, broken)
    if not comboFrame then
        return
    end

    local style = GetComboStyleDefinition()
    local displayComboCount = GetDisplayComboCount()
    local displaySpellID = GetDisplaySpellID(spellID)
    comboFrame.count:SetText(displayComboCount)
    ApplyFont(comboFrame.count, GetStyleCountSize(style, math.max(1, displayComboCount)), "OUTLINE", style.countShadowColor, style.countShadowOffset)
    comboFrame.exclamation:SetText(GetDisplayExclamation())
    comboFrame.icon:SetTexture(GetSpellTextureSafe(displaySpellID) or 136097)
    comboFrame.breakerText:SetShown(broken)
    comboFrame.breakerSlashA:SetShown(broken)
    comboFrame.breakerSlashB:SetShown(broken)
    comboFrame.icon:SetShown(not broken)
    comboFrame.iconBorder:SetShown(not broken)
    comboFrame.count:SetShown(not broken)
    comboFrame.label:SetShown(not broken and (style.labelText or "") ~= "")
    comboFrame.suffix:SetShown(not broken and (style.suffixText or "") ~= "")
    comboFrame.exclamation:SetShown(not broken)

    if broken then
        comboFrame.breakerText:SetText("COMBO BREAKER")
    else
        comboFrame.count:SetTextColor(unpack(style.countColor or { 1, 0.92, 0.42 }))
        comboFrame.exclamation:SetTextColor(unpack(style.exclamationColor or { 1, 0.96, 0.72 }))
    end

    UpdateFrameVisibility()
end

local function ResetCombo()
    state.comboCount = 0
    state.lastSpellID = nil
    state.lastExclamation = ""
    state.comboDisplayExpiresAt = nil
    state.comboBreakerExpiresAt = nil
    ClearComboPreview()

    if comboFrame then
        comboFrame.count:SetText("0")
        comboFrame.exclamation:SetText("")
        comboFrame.icon:SetTexture(136097)
        comboFrame.breakerText:Hide()
        comboFrame.breakerSlashA:Hide()
        comboFrame.breakerSlashB:Hide()
        comboFrame.icon:Show()
        comboFrame.iconBorder:Show()
        comboFrame.count:Show()
        comboFrame.exclamation:Show()
        ApplyComboTheme()
        UpdateComboFrame(state.lastSpellID, false)
    end

    UpdateFrameVisibility()
end

local function PlayMappedSound(spellID)
    if not (state.isWindwalker and MonkFighter2DB.soundsEnabled) then
        return
    end

    local soundFile = GetMappedSoundFile(spellID)
    if not soundFile then
        return
    end

    PlaySoundFile(BuildSoundPath(soundFile), SOUND_CHANNEL)
end

local function PlayComboBreakerSound()
    if not (state.isWindwalker and MonkFighter2DB.soundsEnabled) then
        return
    end

    PlaySoundFile(BuildSoundPath(COMBO_BREAKER_SOUND), SOUND_CHANNEL)
end

local function WillBreakCombo(spellID)
    return COMBO_TRACKED_SPELLS[spellID] and state.lastSpellID == spellID
end

local function AdvanceCombo(spellID)
    if not (state.isWindwalker and MonkFighter2DB.comboEnabled and COMBO_TRACKED_SPELLS[spellID]) then
        return
    end

    ClearComboPreview()
    local sameSpell = state.lastSpellID == spellID
    if sameSpell then
        state.comboCount = 0
        state.lastExclamation = COMBO_RESET_TEXT
        state.comboBreakerExpiresAt = GetTimeSafe() + COMBO_BREAKER_VISUAL_DURATION
        PlayComboBreakerSound()
    else
        state.comboCount = state.comboCount + 1
        state.lastExclamation = GetComboText(state.comboCount)
        state.comboBreakerExpiresAt = nil
    end

    state.lastSpellID = spellID
    state.comboDisplayExpiresAt = math.huge
    UpdateComboFrame(spellID, sameSpell)
end

local function SetComboStyle(styleKey)
    if COMBO_STYLES[styleKey] == nil then
        return
    end

    MonkFighter2DB.comboStyle = styleKey
    UnlockComboHUDForPreview()
    ApplyComboTheme()
    UpdateComboFrame(state.lastSpellID, IsComboBreakerActive())
    RefreshOptionsPanel()
end

local function SetComboFontOverride(fontName)
    MonkFighter2DB.comboFontOverride = fontName
    UnlockComboHUDForPreview()
    ApplyComboTheme()
    UpdateComboFrame(state.lastSpellID, IsComboBreakerActive())
    RefreshOptionsPanel()
end

local function RebuildEventSpellIndex()
    state.eventSpellIndex = {}

    for spellID, config in pairs(SPELL_CONFIGS) do
        if config.soundEvent then
            state.eventSpellIndex[config.soundEvent] = state.eventSpellIndex[config.soundEvent] or {}
            state.eventSpellIndex[config.soundEvent][spellID] = true
        end
    end
end

SetFrameLocked = function(locked)
    MonkFighter2DB.frameLocked = locked

    if comboFrame then
        comboFrame:EnableMouse(not locked)
    end

    if optionsPanel and optionsPanel.lockButton then
        optionsPanel.lockButton:SetText(locked and "Unlock Counter" or "Lock Counter")
    end

    UpdateFrameVisibility()
end

local function ResetFramePosition()
    MonkFighter2DB.framePoint = CopyTable(DEFAULT_FRAME_POINT)
    ApplyFramePosition()
end

local function RefreshSpecState()
    state.isWindwalker = IsWindwalker()

    if not state.isWindwalker then
        ResetCombo()
    else
        UpdateFrameVisibility()
    end
end

local function GetSortedSupportedSpellIDs()
    local spellIDs = {}

    for spellID in pairs(SPELL_CONFIGS) do
        spellIDs[#spellIDs + 1] = spellID
    end

    table.sort(spellIDs, function(leftSpellID, rightSpellID)
        local leftConfig = SPELL_CONFIGS[leftSpellID]
        local rightConfig = SPELL_CONFIGS[rightSpellID]
        local leftOrder = leftConfig and leftConfig.order or leftSpellID
        local rightOrder = rightConfig and rightConfig.order or rightSpellID

        if leftOrder ~= rightOrder then
            return leftOrder < rightOrder
        end

        local leftName = GetConfiguredSpellName(leftSpellID)
        local rightName = GetConfiguredSpellName(rightSpellID)
        return leftName < rightName
    end)

    return spellIDs
end

local function CreateCheckbox(parent, label, tooltipText, onClick)
    local checkbox = CreateFrame("CheckButton", nil, parent, "InterfaceOptionsCheckButtonTemplate")
    checkbox.Text:SetText(label)
    checkbox.tooltipText = tooltipText
    checkbox:SetScript("OnClick", function(buttonSelf)
        onClick(buttonSelf:GetChecked())
    end)
    return checkbox
end

local function CreateDropdown(parent, width)
    local dropdown = CreateFrame("Frame", nil, parent, "UIDropDownMenuTemplate")
    UIDropDownMenu_SetWidth(dropdown, width)
    return dropdown
end

RefreshOptionsPanel = function()
    if not optionsPanel then
        return
    end

    state.refreshingOptions = true
    optionsPanel.soundsCheckbox:SetChecked(MonkFighter2DB.soundsEnabled)
    optionsPanel.comboCheckbox:SetChecked(MonkFighter2DB.comboEnabled)
    optionsPanel.persistCheckbox:SetChecked(MonkFighter2DB.persistCombo)
    optionsPanel.delaySlider:SetValue(MonkFighter2DB.persistHudHideDelay)
    optionsPanel.delaySlider.Text:SetText(string.format("Hide HUD %.0fs after combat", MonkFighter2DB.persistHudHideDelay))
    optionsPanel.lockButton:SetText(MonkFighter2DB.frameLocked and "Unlock Counter" or "Lock Counter")
    UIDropDownMenu_SetText(optionsPanel.styleDropdown, (GetComboStyleDefinition().name or "Default"))

    if optionsPanel.fontDropdown then
        UIDropDownMenu_SetText(optionsPanel.fontDropdown, MonkFighter2DB.comboFontOverride or "Theme Default")
    end

    if optionsPanel.fontHelp then
        if GetSharedMedia() then
            optionsPanel.fontHelp:SetText("LibSharedMedia detected. Choose a registered font override or keep the theme default.")
        else
            optionsPanel.fontHelp:SetText("Install any addon that provides LibSharedMedia-3.0 if you want external font overrides. Themes already fall back cleanly to built-in WoW fonts.")
        end
    end

    local spellIDs = GetSortedSupportedSpellIDs()
    local anchor = optionsPanel.mappingHeader

    for index, row in ipairs(state.optionRows) do
        local spellID = spellIDs[index]
        if spellID then
            row.spellID = spellID
            row.icon:SetTexture(GetSpellTextureSafe(spellID) or 136097)
            row.label:SetText(GetConfiguredSpellName(spellID))

            local config = SPELL_CONFIGS[spellID]
            local eventLabel = (config and config.soundEvent == "UNIT_SPELLCAST_EMPOWER_START") and "Empower Start" or "Cast Success"
            local availabilityLabel = IsSpellKnownSafe(spellID) and "Known now" or "Not currently learned"
            local comboLabel = COMBO_TRACKED_SPELLS[spellID] and "Combo-tracked" or "Sound-only"
            local variantText = config and config.variantNote or ""
            local variantLabel = variantText ~= "" and string.format("%s | %s", comboLabel, variantText) or comboLabel
            row.eventLabel:SetText(string.format("%s | %s", eventLabel, availabilityLabel))
            row.variantLabel:SetText(variantLabel)

            UIDropDownMenu_Initialize(row.dropdown, function(dropdownSelf, level)
                if level ~= 1 then
                    return
                end

                local info = UIDropDownMenu_CreateInfo()
                info.text = GetDefaultSoundLabel(spellID)
                info.func = function()
                    MonkFighter2DB.soundMappings[spellID] = nil
                    UIDropDownMenu_SetText(dropdownSelf, GetDefaultSoundLabel(spellID))
                end
                UIDropDownMenu_AddButton(info, level)

                info = UIDropDownMenu_CreateInfo()
                info.text = "None"
                info.func = function()
                    MonkFighter2DB.soundMappings[spellID] = false
                    UIDropDownMenu_SetText(dropdownSelf, "None")
                end
                UIDropDownMenu_AddButton(info, level)

                for _, soundInfo in ipairs(SOUND_LIBRARY) do
                    info = UIDropDownMenu_CreateInfo()
                    info.text = soundInfo.label
                    info.func = function()
                        MonkFighter2DB.soundMappings[spellID] = soundInfo.file
                        UIDropDownMenu_SetText(dropdownSelf, soundInfo.label)
                    end
                    UIDropDownMenu_AddButton(info, level)
                end
            end)

            local override = MonkFighter2DB.soundMappings[spellID]
            if override == nil then
                UIDropDownMenu_SetText(row.dropdown, GetDefaultSoundLabel(spellID))
            else
                UIDropDownMenu_SetText(row.dropdown, GetSoundChoiceLabel(override))
            end

            row:ClearAllPoints()
            row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -12 - ((index - 1) * 52))
            row:SetShown(true)
        else
            row:SetShown(false)
        end
    end

    local contentHeight = math.max(900, 520 + (#spellIDs * 52))
    optionsPanel.content:SetHeight(contentHeight)
    state.refreshingOptions = false
end

local function OpenOptionsPanel()
    if state.optionsCategory and Settings and Settings.OpenToCategory then
        Settings.OpenToCategory(state.optionsCategory:GetID())
        return
    end

    if InterfaceOptionsFrame_OpenToCategory and optionsPanel then
        InterfaceOptionsFrame_OpenToCategory(optionsPanel)
        InterfaceOptionsFrame_OpenToCategory(optionsPanel)
    end
end

local function CreateOptionsPanel()
    optionsPanel = CreateFrame("Frame", addonName .. "OptionsPanel", UIParent)
    optionsPanel.name = "MonkFighter2"

    local scrollFrame = CreateFrame("ScrollFrame", addonName .. "OptionsScrollFrame", optionsPanel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", optionsPanel, "TOPLEFT", 16, -16)
    scrollFrame:SetPoint("BOTTOMRIGHT", optionsPanel, "BOTTOMRIGHT", -30, 16)

    optionsPanel.content = CreateFrame("Frame", nil, scrollFrame)
    optionsPanel.content:SetSize(620, 900)
    scrollFrame:SetScrollChild(optionsPanel.content)

    local content = optionsPanel.content

    local title = content:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("MonkFighter2")

    local subtitle = content:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetWidth(620)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetText("Street Fighter sound replacements plus a combo counter for Windwalker Monk.")

    optionsPanel.soundsCheckbox = CreateCheckbox(content, "Enable sounds", "Play mapped sound effects for supported monk abilities.", function(checked)
        MonkFighter2DB.soundsEnabled = checked
    end)
    optionsPanel.soundsCheckbox:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -18)

    optionsPanel.comboCheckbox = CreateCheckbox(content, "Enable combo counter", "Show the combo HUD in combat and track repeated supported abilities.", function(checked)
        MonkFighter2DB.comboEnabled = checked
        UpdateFrameVisibility()
        RefreshOptionsPanel()
    end)
    optionsPanel.comboCheckbox:SetPoint("TOPLEFT", optionsPanel.soundsCheckbox, "BOTTOMLEFT", 0, -8)

    optionsPanel.persistCheckbox = CreateCheckbox(content, "Persist combo out of combat", "Keep the combo count and display after combat ends until you break the combo or change context.", function(checked)
        MonkFighter2DB.persistCombo = checked
        UpdateFrameVisibility()
        RefreshOptionsPanel()
    end)
    optionsPanel.persistCheckbox:SetPoint("TOPLEFT", optionsPanel.comboCheckbox, "BOTTOMLEFT", 0, -8)

    optionsPanel.delaySlider = CreateFrame("Slider", addonName .. "PersistDelaySlider", content, "OptionsSliderTemplate")
    optionsPanel.delaySlider:SetWidth(220)
    optionsPanel.delaySlider:SetPoint("TOPLEFT", optionsPanel.persistCheckbox, "BOTTOMLEFT", 4, -24)
    optionsPanel.delaySlider:SetMinMaxValues(0, 30)
    optionsPanel.delaySlider:SetValueStep(1)
    optionsPanel.delaySlider:SetObeyStepOnDrag(true)
    optionsPanel.delaySlider.Low:SetText("0s")
    optionsPanel.delaySlider.High:SetText("30s")
    optionsPanel.delaySlider:SetScript("OnValueChanged", function(_, value)
        local roundedValue = math.floor(value + 0.5)
        MonkFighter2DB.persistHudHideDelay = roundedValue
        optionsPanel.delaySlider.Text:SetText(string.format("Hide HUD %.0fs after combat", roundedValue))
        if state.refreshingOptions then
            return
        end
        if not InCombatLockdown() and state.comboCount > 0 and MonkFighter2DB.persistCombo then
            state.comboDisplayExpiresAt = GetTimeSafe() + roundedValue
            UpdateFrameVisibility()
        end
        RefreshOptionsPanel()
    end)

    optionsPanel.lockButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    optionsPanel.lockButton:SetSize(120, 24)
    optionsPanel.lockButton:SetPoint("TOPLEFT", optionsPanel.delaySlider, "BOTTOMLEFT", 0, -18)
    optionsPanel.lockButton:SetScript("OnClick", function()
        if MonkFighter2DB.frameLocked then
            UnlockComboHUDForPreview()
            UpdateComboFrame(state.lastSpellID, false)
        else
            ClearComboPreview()
            SetFrameLocked(true)
        end
        RefreshOptionsPanel()
    end)

    optionsPanel.resetButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    optionsPanel.resetButton:SetSize(110, 24)
    optionsPanel.resetButton:SetPoint("LEFT", optionsPanel.lockButton, "RIGHT", 8, 0)
    optionsPanel.resetButton:SetText("Reset Position")
    optionsPanel.resetButton:SetScript("OnClick", function()
        ResetFramePosition()
    end)

    local styleLabel = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    styleLabel:SetPoint("TOPLEFT", optionsPanel.lockButton, "BOTTOMLEFT", 0, -18)
    styleLabel:SetText("Combo HUD Style")

    optionsPanel.styleDropdown = CreateDropdown(content, 220)
    optionsPanel.styleDropdown:SetPoint("TOPLEFT", styleLabel, "BOTTOMLEFT", -12, -4)
    UIDropDownMenu_Initialize(optionsPanel.styleDropdown, function(_, level)
        if level ~= 1 then
            return
        end

        for _, styleKey in ipairs(GetOrderedComboStyleKeys()) do
            local style = COMBO_STYLES[styleKey]
            local info = UIDropDownMenu_CreateInfo()
            info.text = style.name
            info.checked = MonkFighter2DB.comboStyle == styleKey
            info.func = function()
                SetComboStyle(styleKey)
                UIDropDownMenu_SetText(optionsPanel.styleDropdown, style.name)
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)

    local fontLabel = content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    fontLabel:SetPoint("TOPLEFT", optionsPanel.styleDropdown, "BOTTOMLEFT", 16, -12)
    fontLabel:SetText("Font Override")

    optionsPanel.fontDropdown = CreateDropdown(content, 220)
    optionsPanel.fontDropdown:SetPoint("TOPLEFT", fontLabel, "BOTTOMLEFT", -12, -4)
    UIDropDownMenu_Initialize(optionsPanel.fontDropdown, function(_, level)
        if level ~= 1 then
            return
        end

        local info = UIDropDownMenu_CreateInfo()
        info.text = "Theme Default"
        info.checked = MonkFighter2DB.comboFontOverride == nil
        info.func = function()
            SetComboFontOverride(nil)
            UIDropDownMenu_SetText(optionsPanel.fontDropdown, "Theme Default")
        end
        UIDropDownMenu_AddButton(info, level)

        local fontNames = GetSharedMediaFontNames()
        if not fontNames then
            info = UIDropDownMenu_CreateInfo()
            info.text = "LibSharedMedia not available"
            info.isTitle = true
            info.notCheckable = true
            UIDropDownMenu_AddButton(info, level)
            return
        end

        for _, fontName in ipairs(fontNames) do
            info = UIDropDownMenu_CreateInfo()
            info.text = fontName
            info.checked = MonkFighter2DB.comboFontOverride == fontName
            info.func = function()
                SetComboFontOverride(fontName)
                UIDropDownMenu_SetText(optionsPanel.fontDropdown, fontName)
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end)

    optionsPanel.fontHelp = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    optionsPanel.fontHelp:SetPoint("TOPLEFT", optionsPanel.fontDropdown, "BOTTOMLEFT", 16, -4)
    optionsPanel.fontHelp:SetWidth(620)
    optionsPanel.fontHelp:SetJustifyH("LEFT")

    local helpText = content:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    helpText:SetPoint("TOPLEFT", optionsPanel.fontHelp, "BOTTOMLEFT", -16, -12)
    helpText:SetWidth(620)
    helpText:SetJustifyH("LEFT")
    helpText:SetText("Choose a sound for any supported Windwalker ability variant, even if it is not currently talented. This keeps mutually exclusive nodes and replacement spells configurable ahead of time.")

    optionsPanel.mappingHeader = optionsPanel.content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    optionsPanel.mappingHeader:SetPoint("TOPLEFT", helpText, "BOTTOMLEFT", 0, -18)
    optionsPanel.mappingHeader:SetText("Ability Sound Mapping")

    for index = 1, 24 do
        local row = CreateFrame("Frame", nil, optionsPanel.content)
        row:SetSize(620, 48)

        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(20, 20)
        row.icon:SetPoint("LEFT", row, "LEFT", 2, 0)

        row.label = row:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        row.label:SetPoint("LEFT", row.icon, "RIGHT", 8, 6)
        row.label:SetWidth(220)
        row.label:SetJustifyH("LEFT")

        row.eventLabel = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        row.eventLabel:SetPoint("TOPLEFT", row.label, "BOTTOMLEFT", 0, -2)
        row.eventLabel:SetTextColor(0.65, 0.65, 0.65)

        row.variantLabel = row:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
        row.variantLabel:SetPoint("TOPLEFT", row.eventLabel, "BOTTOMLEFT", 0, -2)
        row.variantLabel:SetWidth(280)
        row.variantLabel:SetJustifyH("LEFT")
        row.variantLabel:SetTextColor(0.82, 0.72, 0.46)

        row.dropdown = CreateDropdown(row, 200)
        row.dropdown:SetPoint("LEFT", row, "LEFT", 330, -4)

        state.optionRows[index] = row
    end

    optionsPanel:SetScript("OnShow", RefreshOptionsPanel)

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        state.optionsCategory = Settings.RegisterCanvasLayoutCategory(optionsPanel, optionsPanel.name, optionsPanel.name)
        Settings.RegisterAddOnCategory(state.optionsCategory)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(optionsPanel)
    end
end

local function CreateComboFrame()
    comboFrame = CreateFrame("Frame", "MonkFighter2ComboFrame", UIParent)
    comboFrame:SetSize(268, 92)
    comboFrame:SetMovable(true)
    comboFrame:RegisterForDrag("LeftButton")
    comboFrame:SetClampedToScreen(true)
    comboFrame:SetScript("OnDragStart", function(frameSelf)
        if not MonkFighter2DB.frameLocked then
            frameSelf:StartMoving()
        end
    end)
    comboFrame:SetScript("OnDragStop", function(frameSelf)
        frameSelf:StopMovingOrSizing()
        SaveFramePosition()
    end)

    comboFrame.bg = comboFrame:CreateTexture(nil, "BACKGROUND")
    comboFrame.bg:SetAllPoints()
    comboFrame.bg:SetTexture(WHITE_TEXTURE)

    comboFrame.edgeTop = comboFrame:CreateTexture(nil, "BORDER")
    comboFrame.edgeTop:SetPoint("TOPLEFT", comboFrame, "TOPLEFT", 0, 0)
    comboFrame.edgeTop:SetPoint("TOPRIGHT", comboFrame, "TOPRIGHT", 0, 0)
    comboFrame.edgeTop:SetHeight(3)
    comboFrame.edgeTop:SetTexture(WHITE_TEXTURE)

    comboFrame.icon = comboFrame:CreateTexture(nil, "ARTWORK")
    comboFrame.icon:SetSize(48, 48)
    comboFrame.icon:SetPoint("LEFT", comboFrame, "LEFT", 8, 0)
    comboFrame.icon:SetTexture(136097)

    comboFrame.iconBorder = comboFrame:CreateTexture(nil, "OVERLAY")
    comboFrame.iconBorder:SetPoint("TOPLEFT", comboFrame.icon, "TOPLEFT", -2, 2)
    comboFrame.iconBorder:SetPoint("BOTTOMRIGHT", comboFrame.icon, "BOTTOMRIGHT", 2, -2)
    comboFrame.iconBorder:SetTexture(WHITE_TEXTURE)

    comboFrame.count = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.count:SetPoint("LEFT", comboFrame.icon, "RIGHT", 18, 8)
    comboFrame.count:SetJustifyH("LEFT")
    comboFrame.count:SetFont(FONT_PATH, 34, "OUTLINE")
    comboFrame.count:SetText("0")

    comboFrame.label = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.label:SetPoint("BOTTOMLEFT", comboFrame.count, "TOPLEFT", 0, -2)
    comboFrame.label:SetFont(FONT_PATH, 12, "OUTLINE")
    comboFrame.label:SetText("COMBO")

    comboFrame.suffix = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.suffix:SetFont(FONT_PATH, 12, "OUTLINE")
    comboFrame.suffix:SetText("")

    comboFrame.exclamation = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.exclamation:SetPoint("TOPLEFT", comboFrame.count, "BOTTOMLEFT", 0, -2)
    comboFrame.exclamation:SetPoint("RIGHT", comboFrame, "RIGHT", -12, 0)
    comboFrame.exclamation:SetJustifyH("LEFT")
    comboFrame.exclamation:SetFont(FONT_PATH, 16, "OUTLINE")
    comboFrame.exclamation:SetText("")

    comboFrame.breakerSlashA = comboFrame:CreateTexture(nil, "OVERLAY")
    comboFrame.breakerSlashA:SetTexture(WHITE_TEXTURE)
    comboFrame.breakerSlashA:SetSize(180, 8)
    comboFrame.breakerSlashA:SetPoint("CENTER", comboFrame, "CENTER", 0, -2)
    SetTextureRotationSafe(comboFrame.breakerSlashA, math.rad(-18))
    comboFrame.breakerSlashA:Hide()

    comboFrame.breakerSlashB = comboFrame:CreateTexture(nil, "OVERLAY")
    comboFrame.breakerSlashB:SetTexture(WHITE_TEXTURE)
    comboFrame.breakerSlashB:SetSize(140, 4)
    comboFrame.breakerSlashB:SetPoint("CENTER", comboFrame, "CENTER", 14, 8)
    SetTextureRotationSafe(comboFrame.breakerSlashB, math.rad(-18))
    comboFrame.breakerSlashB:Hide()

    comboFrame.breakerText = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.breakerText:SetPoint("CENTER", comboFrame, "CENTER", 0, 0)
    comboFrame.breakerText:SetFont(FONT_PATH, 20, "OUTLINE")
    comboFrame.breakerText:SetText("COMBO BREAKER")
    comboFrame.breakerText:Hide()

    comboFrame.moveHint = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.moveHint:SetPoint("TOP", comboFrame, "TOP", 0, -10)
    comboFrame.moveHint:SetFont(FONT_PATH, 11, "OUTLINE")
    comboFrame.moveHint:SetText("Drag to move")
    comboFrame.moveHint:Hide()

    comboFrame:SetScript("OnUpdate", function()
        if state.comboBreakerExpiresAt and GetTimeSafe() >= state.comboBreakerExpiresAt then
            state.comboBreakerExpiresAt = nil
            comboFrame.breakerText:Hide()
            comboFrame.breakerSlashA:Hide()
            comboFrame.breakerSlashB:Hide()
            UpdateComboFrame(state.lastSpellID, false)
        end

        if not state.isWindwalker or not MonkFighter2DB.comboEnabled or InCombatLockdown() then
            return
        end

        if state.comboDisplayExpiresAt and state.comboDisplayExpiresAt ~= math.huge and GetTimeSafe() >= state.comboDisplayExpiresAt then
            UpdateFrameVisibility()
        end
    end)

    ApplyFramePosition()
    ApplyComboTheme()
    comboFrame:Hide()
end

SlashCmdList.MONKFIGHTER2 = function(message)
    local command = message and message:lower():match("^%s*(.-)%s*$") or ""

    if command == "unlock" then
        SetFrameLocked(false)
        return
    end

    if command == "lock" then
        SetFrameLocked(true)
        return
    end

    if command == "reset" then
        ResetFramePosition()
        return
    end

    -- if command == "debugcombo" then
    --     state.debugComboAura = not state.debugComboAura
    --     state.lastAuraInstanceID = nil
    --     state.lastAuraLabel = nil
    --     state.lastComboAuraSummary = nil
    --     DebugPrint("combo aura debug " .. (state.debugComboAura and "enabled" or "disabled"))
    --     if state.debugComboAura then
    --         DebugReportComboAura("snapshot")
    --     end
    --     return
    -- end

    OpenOptionsPanel()
end

SLASH_MONKFIGHTER21 = "/monkfighter2"
SLASH_MONKFIGHTER22 = "/mf2"

ADDON:SetScript("OnEvent", function(_, event, ...)
    if event == "ADDON_LOADED" then
        local loadedName = ...
        if loadedName ~= addonName then
            return
        end

        EnsureDB()
        MonkFighter2DB.frameLocked = true
        RebuildEventSpellIndex()
        CreateComboFrame()
        CreateOptionsPanel()
        ResetCombo()
        SetFrameLocked(true)
        RefreshOptionsPanel()
        RefreshSpecState()
        return
    end

    if event == "PLAYER_LOGIN" or event == "PLAYER_ENTERING_WORLD" then
        RefreshSpecState()
        return
    end

    if event == "PLAYER_SPECIALIZATION_CHANGED" then
        local unit = ...
        if unit == "player" then
            RefreshSpecState()
            RefreshOptionsPanel()
        end
        return
    end

    if event == "SPELLS_CHANGED" then
        RefreshSpecState()
        RefreshOptionsPanel()
        return
    end

    -- if event == "UNIT_AURA" then
    --     local unitTarget = ...
    --     if unitTarget == "player" then
    --         DebugReportComboAura("unit_aura")
    --     end
    --     return
    -- end

    if event == "PLAYER_REGEN_DISABLED" then
        state.comboDisplayExpiresAt = math.huge
        UpdateFrameVisibility()
        return
    end

    if event == "PLAYER_REGEN_ENABLED" then
        if MonkFighter2DB.persistCombo and state.comboCount > 0 then
            state.comboDisplayExpiresAt = GetTimeSafe() + (MonkFighter2DB.persistHudHideDelay or 10)
        else
            state.comboDisplayExpiresAt = nil
        end
        UpdateFrameVisibility()
        return
    end

    if state.eventSpellIndex[event] or event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unitTarget, _, spellID = ...
        if unitTarget ~= "player" or not spellID then
            return
        end

        local suppressMappedSound = event == "UNIT_SPELLCAST_SUCCEEDED" and WillBreakCombo(spellID)

        if state.eventSpellIndex[event] and state.eventSpellIndex[event][spellID] and not suppressMappedSound then
            PlayMappedSound(spellID)
        end

        -- DebugReportComboAura("cast", spellID)

        if event == "UNIT_SPELLCAST_SUCCEEDED" then
            AdvanceCombo(spellID)
        end
    end
end)

ADDON:RegisterEvent("ADDON_LOADED")
ADDON:RegisterEvent("PLAYER_LOGIN")
ADDON:RegisterEvent("PLAYER_ENTERING_WORLD")
ADDON:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
ADDON:RegisterEvent("PLAYER_REGEN_DISABLED")
ADDON:RegisterEvent("PLAYER_REGEN_ENABLED")
ADDON:RegisterEvent("SPELLS_CHANGED")
-- ADDON:RegisterUnitEvent("UNIT_AURA", "player")
ADDON:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_START", "player")
ADDON:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
