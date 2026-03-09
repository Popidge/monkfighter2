local addonName, ns = ...
ns = ns or {}

local ADDON = CreateFrame("Frame")
ns.ADDON = ADDON

local SPEC_WINDWALKER = 269
local SOUND_CHANNEL = "SFX"
local COMBO_RESET_TEXT = "Combo Broken!"
local COMBO_BREAKER_SOUND = "combo_breaker.ogg"
local COMBO_TRACKER_AURA_ID = 1249753
local FONT_PATH = "Fonts\\FRIZQT__.TTF"
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

local defaults = {
    soundsEnabled = true,
    comboEnabled = true,
    persistCombo = true,
    persistHudHideDelay = 10,
    frameLocked = true,
    framePoint = DEFAULT_FRAME_POINT,
    soundMappings = {},
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
    eventSpellIndex = {},
    optionRows = {},
    optionsCategory = nil,
}

local comboFrame
local optionsPanel

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
    if C_Spell and C_Spell.GetSpellTexture then
        return C_Spell.GetSpellTexture(spellID)
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

local function GetComboText(comboCount)
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
    local shouldShow = state.isWindwalker and (not MonkFighter2DB.frameLocked or comboVisible)
    comboFrame:SetShown(shouldShow)
    comboFrame.moveHint:SetShown(not MonkFighter2DB.frameLocked)
end

local function UpdateComboFrame(spellID, broken)
    if not comboFrame then
        return
    end

    comboFrame.count:SetText(state.comboCount)
    comboFrame.count:SetFont(FONT_PATH, GetComboFontSize(state.comboCount), "OUTLINE")
    comboFrame.exclamation:SetText(state.lastExclamation)
    comboFrame.icon:SetTexture(GetSpellTextureSafe(spellID) or 136097)

    if broken then
        comboFrame.count:SetTextColor(1, 0.25, 0.25)
        comboFrame.exclamation:SetTextColor(1, 0.4, 0.4)
    else
        comboFrame.count:SetTextColor(1, 0.92, 0.42)
        comboFrame.exclamation:SetTextColor(1, 0.96, 0.72)
    end

    UpdateFrameVisibility()
end

local function ResetCombo()
    state.comboCount = 0
    state.lastSpellID = nil
    state.lastExclamation = ""
    state.comboDisplayExpiresAt = nil

    if comboFrame then
        comboFrame.count:SetText("0")
        comboFrame.count:SetFont(FONT_PATH, 34, "OUTLINE")
        comboFrame.count:SetTextColor(1, 0.92, 0.42)
        comboFrame.exclamation:SetText("")
        comboFrame.exclamation:SetTextColor(1, 0.96, 0.72)
        comboFrame.icon:SetTexture(136097)
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

    local sameSpell = state.lastSpellID == spellID
    if sameSpell then
        state.comboCount = 0
        state.lastExclamation = COMBO_RESET_TEXT
        PlayComboBreakerSound()
    else
        state.comboCount = state.comboCount + 1
        state.lastExclamation = GetComboText(state.comboCount)
    end

    state.lastSpellID = spellID
    state.comboDisplayExpiresAt = math.huge
    UpdateComboFrame(spellID, sameSpell)
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

local function SetFrameLocked(locked)
    MonkFighter2DB.frameLocked = locked

    if comboFrame then
        comboFrame:EnableMouse(not locked)
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

local function RefreshOptionsPanel()
    if not optionsPanel then
        return
    end

    optionsPanel.soundsCheckbox:SetChecked(MonkFighter2DB.soundsEnabled)
    optionsPanel.comboCheckbox:SetChecked(MonkFighter2DB.comboEnabled)
    optionsPanel.persistCheckbox:SetChecked(MonkFighter2DB.persistCombo)
    optionsPanel.delaySlider:SetValue(MonkFighter2DB.persistHudHideDelay)
    optionsPanel.delaySlider.Text:SetText(string.format("Hide HUD %.0fs after combat", MonkFighter2DB.persistHudHideDelay))
    optionsPanel.lockButton:SetText(MonkFighter2DB.frameLocked and "Unlock Counter" or "Lock Counter")

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

    local contentHeight = math.max(560, 220 + (#spellIDs * 52))
    optionsPanel.content:SetHeight(contentHeight)
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

    local title = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("MonkFighter2")

    local subtitle = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    subtitle:SetWidth(620)
    subtitle:SetJustifyH("LEFT")
    subtitle:SetText("Street Fighter sound replacements plus a combo counter for Windwalker Monk.")

    optionsPanel.soundsCheckbox = CreateCheckbox(optionsPanel, "Enable sounds", "Play mapped sound effects for supported monk abilities.", function(checked)
        MonkFighter2DB.soundsEnabled = checked
    end)
    optionsPanel.soundsCheckbox:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", -2, -18)

    optionsPanel.comboCheckbox = CreateCheckbox(optionsPanel, "Enable combo counter", "Show the combo HUD in combat and track repeated supported abilities.", function(checked)
        MonkFighter2DB.comboEnabled = checked
        UpdateFrameVisibility()
    end)
    optionsPanel.comboCheckbox:SetPoint("TOPLEFT", optionsPanel.soundsCheckbox, "BOTTOMLEFT", 0, -8)

    optionsPanel.persistCheckbox = CreateCheckbox(optionsPanel, "Persist combo out of combat", "Keep the combo count and display after combat ends until you break the combo or change context.", function(checked)
        MonkFighter2DB.persistCombo = checked
        UpdateFrameVisibility()
    end)
    optionsPanel.persistCheckbox:SetPoint("TOPLEFT", optionsPanel.comboCheckbox, "BOTTOMLEFT", 0, -8)

    optionsPanel.delaySlider = CreateFrame("Slider", addonName .. "PersistDelaySlider", optionsPanel, "OptionsSliderTemplate")
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
        if not InCombatLockdown() and state.comboCount > 0 and MonkFighter2DB.persistCombo then
            state.comboDisplayExpiresAt = GetTimeSafe() + roundedValue
            UpdateFrameVisibility()
        end
    end)

    optionsPanel.lockButton = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
    optionsPanel.lockButton:SetSize(120, 24)
    optionsPanel.lockButton:SetPoint("TOPLEFT", optionsPanel.delaySlider, "BOTTOMLEFT", 0, -18)
    optionsPanel.lockButton:SetScript("OnClick", function()
        SetFrameLocked(not MonkFighter2DB.frameLocked)
        RefreshOptionsPanel()
    end)

    optionsPanel.resetButton = CreateFrame("Button", nil, optionsPanel, "UIPanelButtonTemplate")
    optionsPanel.resetButton:SetSize(110, 24)
    optionsPanel.resetButton:SetPoint("LEFT", optionsPanel.lockButton, "RIGHT", 8, 0)
    optionsPanel.resetButton:SetText("Reset Position")
    optionsPanel.resetButton:SetScript("OnClick", function()
        ResetFramePosition()
    end)

    local helpText = optionsPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
    helpText:SetPoint("TOPLEFT", optionsPanel.lockButton, "BOTTOMLEFT", 0, -10)
    helpText:SetWidth(620)
    helpText:SetJustifyH("LEFT")
    helpText:SetText("Choose a sound for any supported Windwalker ability variant, even if it is not currently talented. This keeps mutually exclusive nodes and replacement spells configurable ahead of time.")

    local scrollFrame = CreateFrame("ScrollFrame", addonName .. "OptionsScrollFrame", optionsPanel, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", helpText, "BOTTOMLEFT", 0, -14)
    scrollFrame:SetPoint("BOTTOMRIGHT", optionsPanel, "BOTTOMRIGHT", -30, 16)

    optionsPanel.content = CreateFrame("Frame", nil, scrollFrame)
    optionsPanel.content:SetSize(620, 480)
    scrollFrame:SetScrollChild(optionsPanel.content)

    optionsPanel.mappingHeader = optionsPanel.content:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    optionsPanel.mappingHeader:SetPoint("TOPLEFT", 0, 0)
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
    comboFrame:SetSize(250, 96)
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
    comboFrame.bg:SetColorTexture(0.06, 0.04, 0.02, 0.68)

    comboFrame.edgeTop = comboFrame:CreateTexture(nil, "BORDER")
    comboFrame.edgeTop:SetPoint("TOPLEFT", comboFrame, "TOPLEFT", 0, 0)
    comboFrame.edgeTop:SetPoint("TOPRIGHT", comboFrame, "TOPRIGHT", 0, 0)
    comboFrame.edgeTop:SetHeight(3)
    comboFrame.edgeTop:SetColorTexture(0.96, 0.71, 0.15, 0.95)

    comboFrame.icon = comboFrame:CreateTexture(nil, "ARTWORK")
    comboFrame.icon:SetSize(52, 52)
    comboFrame.icon:SetPoint("LEFT", comboFrame, "LEFT", 12, 0)
    comboFrame.icon:SetTexture(136097)

    comboFrame.iconBorder = comboFrame:CreateTexture(nil, "OVERLAY")
    comboFrame.iconBorder:SetPoint("TOPLEFT", comboFrame.icon, "TOPLEFT", -2, 2)
    comboFrame.iconBorder:SetPoint("BOTTOMRIGHT", comboFrame.icon, "BOTTOMRIGHT", 2, -2)
    comboFrame.iconBorder:SetColorTexture(0.94, 0.74, 0.16, 0.16)

    comboFrame.count = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.count:SetPoint("LEFT", comboFrame.icon, "RIGHT", 18, 8)
    comboFrame.count:SetFont(FONT_PATH, 34, "OUTLINE")
    comboFrame.count:SetJustifyH("LEFT")
    comboFrame.count:SetTextColor(1, 0.92, 0.42)
    comboFrame.count:SetText("0")

    comboFrame.label = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.label:SetPoint("BOTTOMLEFT", comboFrame.count, "TOPLEFT", 0, -2)
    comboFrame.label:SetFont(FONT_PATH, 12, "OUTLINE")
    comboFrame.label:SetTextColor(1, 0.78, 0.24)
    comboFrame.label:SetText("COMBO")

    comboFrame.exclamation = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.exclamation:SetPoint("TOPLEFT", comboFrame.count, "BOTTOMLEFT", 0, -2)
    comboFrame.exclamation:SetPoint("RIGHT", comboFrame, "RIGHT", -12, 0)
    comboFrame.exclamation:SetFont(FONT_PATH, 16, "OUTLINE")
    comboFrame.exclamation:SetJustifyH("LEFT")
    comboFrame.exclamation:SetTextColor(1, 0.96, 0.72)
    comboFrame.exclamation:SetText("")

    comboFrame.moveHint = comboFrame:CreateFontString(nil, "OVERLAY")
    comboFrame.moveHint:SetPoint("TOP", comboFrame, "TOP", 0, -10)
    comboFrame.moveHint:SetFont(FONT_PATH, 11, "OUTLINE")
    comboFrame.moveHint:SetTextColor(0.96, 0.71, 0.15)
    comboFrame.moveHint:SetText("Drag to move")
    comboFrame.moveHint:Hide()

    comboFrame:SetScript("OnUpdate", function()
        if not state.isWindwalker or not MonkFighter2DB.comboEnabled or InCombatLockdown() then
            return
        end

        if state.comboDisplayExpiresAt and state.comboDisplayExpiresAt ~= math.huge and GetTimeSafe() >= state.comboDisplayExpiresAt then
            UpdateFrameVisibility()
        end
    end)

    ApplyFramePosition()
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
        RebuildEventSpellIndex()
        CreateComboFrame()
        CreateOptionsPanel()
        SetFrameLocked(MonkFighter2DB.frameLocked)
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
