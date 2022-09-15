local E = unpack(select(2, ...))

local pairs, strjoin, tonumber = pairs, strjoin, tonumber

local C_PetJournalGetSummonedPetGUID, C_MountJournalGetMountIDs, C_MountJournalGetMountInfoByID = C_PetJournal.GetSummonedPetGUID, C_MountJournal.GetMountIDs, C_MountJournal.GetMountInfoByID
local C_MapGetMapInfo, C_MapGetBestMapForUnit = C_Map.GetMapInfo, C_Map.GetBestMapForUnit

function E:GetPetGUID()
    local summonedPetGUID = C_PetJournalGetSummonedPetGUID()
    if summonedPetGUID then self.Print(summonedPetGUID) end
end

function E:ChatCommand_GetMountID(spellID)
    if spellID == nil then return end
    local mountIDs = C_MountJournalGetMountIDs
    for _, mountID in pairs(mountIDs) do
        local mountName, mountSpellID = C_MountJournalGetMountInfoByID(mountID)

        if mountSpellID == tonumber(spellID) then self.Print(strjoin(' ', mountName, mountID)) end
    end
end

function E.GetZoneID() return C_MapGetBestMapForUnit('player') end

function E:ChatCommand_ShowZoneID()
    local id = self.GetZoneID()
    self.Print(strjoin(' - ', id, C_MapGetMapInfo(id).name))
end

function E:LoadCommands()
    self:RegisterChatCommand('petguid', 'GetPetGUID')
    self:RegisterChatCommand('mountid', 'GetMountID')
    self:RegisterChatCommand('zoneid', 'ChatCommand_ShowZoneID')
end