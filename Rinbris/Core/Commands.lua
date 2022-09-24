local E = unpack(select(2, ...))

-- Lua APIs
local tonumber = tonumber
local strjoin = strjoin
local pairs = pairs

-- Blizzard Globals
local C_PetJournalGetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local C_MountJournalGetMountInfoByID = C_MountJournal.GetMountInfoByID
local C_MountJournalGetMountIDs = C_MountJournal.GetMountIDs

local C_MapGetBestMapForUnit = C_Map.GetBestMapForUnit
local C_MapGetMapInfo = C_Map.GetMapInfo

function E:SetPetGUID(guid)
    E.db.misc.companion = guid
end

function E:GetPetGUID()
    local summonedPetGUID = C_PetJournalGetSummonedPetGUID()
    if summonedPetGUID then
        self.Print(summonedPetGUID)
    end
end

function E:ChatCommand_GetMountID(spellID)
    if spellID == nil then
        return
    end

    local mountIDs = C_MountJournalGetMountIDs
    for _, mountID in pairs(mountIDs) do
        local mountName, mountSpellID = C_MountJournalGetMountInfoByID(mountID)

        if mountSpellID == tonumber(spellID) then
            self.Print(strjoin(' ', mountName, mountID))
        end
    end
end

function E:ChatCommand_ShowZoneID()
    local id = C_MapGetBestMapForUnit('player')
    self.Print(strjoin(' - ', id, C_MapGetMapInfo(id).name))
end

function E:LoadCommands()
    self:RegisterChatCommand('setpetguid', 'SetPetGUID')
    self:RegisterChatCommand('petguid', 'GetPetGUID')
    self:RegisterChatCommand('mountid', 'GetMountID')
    self:RegisterChatCommand('zoneid', 'ChatCommand_ShowZoneID')
end