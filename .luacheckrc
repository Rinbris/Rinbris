std = "lua51"
max_line_length = false
exclude_files = {
    "Rinbris/Libraries/*",
    "Rinbris_Options/Libraries/*",
    ".luacheckrc"
}
ignore = {
	"43.", -- Shadowing an upvalue, an upvalue argument, an upvalue loop variable.
    "542", -- An empty if branch
}
globals = {
	"_G",
	"strjoin",
    "strsplit",
    "format",
    "wipe",
    "hooksecurefunc",

    -- Rinbris
    "Rinbris",
    "RinbrisDB",
    "RinbrisPrivateDB",
    "RinbrisCharacterDB",

    -- Third Party Addons/Libs
    "TRP3_ToolbarTopFrame",
    "TRP3_API",
    "Storyline_NPCFrameConfigButton",
    "Storyline_NPCFrameLock",
    "Storyline_NPCFrameClose",
    "Storyline_NPCFrameResizeButton",

    -- FrameXML frames
    "UIParent",
    "ChatFrame1",
    "LootFrame",
    "ObjectiveTrackerFrame",
    "GameTooltip",
    "ChatFrameMenuButton",
    "FCF_GetCurrentChatFrame",
    "QuickJoinToastButton",
    "ChatFrameChannelButton",
    "GeneralDockManager",
    "StatusTrackingBarManager",
    "MinimapCluster",

    -- FrameXML globals
    "DEFAULT_CHATFRAME_ALPHA",

    -- ENUMS
    "NUM_BAG_SLOTS",
    "NUM_CHAT_WINDOWS",

    -- API functions
    "CanGuildBankRepair",
    "CanMerchantRepair",
    "CreateFrame",

    "DisableAddOn",

    "GetAddOnInfo",
    "GetAddOnMetadata",
    "GetNumAddOns",
    "GetSpecializationInfo",
    "GetSpecialization",
    "GetRealmName",
    "GetLootSlotInfo",
    "GetNumSpecializations",
    "GetNumLootItems",
    "GetContainerItemInfo",
    "GetItemInfo",
    "GetLocale",
    "GetRepairAllCost",
    "GetContainerNumSlots",

    "LootSlot",

    "MuteSoundFile",

    "IsAddOnLoaded",
    "IsInInstance",
    "IsShiftKeyDown",
    "IsStealthed",
    "IsInGuild",
    "IsModifierKeyDown",

    "InCombatLockdown",

    "ObjectiveTracker_Collapse",
    "ObjectiveTracker_Expand",

    "ReloadUI",
    "RepairAllItems",
    "RepopMe",

    "C_PetJournal",
    "C_Timer",
    "C_QuestLog",
    "C_PetJournal",

    "UnitLevel",
    "UnitName",
    "UnitRace",
    "UnitClass",
    "UnitFactionGroup",
    "UnitGUID",

    "UseContainerItem",
}