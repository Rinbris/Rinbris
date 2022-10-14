local E = unpack(select(2, ...))

-- Lua APIs
local tonumber = tonumber
local strjoin = strjoin
local select = select
local pairs = pairs

-- WoW APIs
local C_PetJournalGetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local C_PetJournalGetPetInfoByPetID = C_PetJournal.GetPetInfoByPetID
local C_MountJournalGetMountInfoByID = C_MountJournal.GetMountInfoByID
local C_MountJournalGetMountIDs = C_MountJournal.GetMountIDs

local C_MapGetBestMapForUnit = C_Map.GetBestMapForUnit
local C_MapGetMapInfo = C_Map.GetMapInfo

function E:SetPetID(petID)
    if petID == nil then
        return
    end

    local name = select(8, C_PetJournalGetPetInfoByPetID(petID))
    if name then
        RinbrisCharacterDB.battlePet = petID
        self.Print(name .. ' configured.')
    end
end

function E:GetPetID()
    local summonedPetGUID = C_PetJournalGetSummonedPetGUID()
    if summonedPetGUID then
        self.Print('Current petID is : ' .. summonedPetGUID)
    end
end

function E:CheckPetID()
    local characterBattlePet = RinbrisCharacterDB.battlePet
    if characterBattlePet then
        self.Print(select(8, C_PetJournalGetPetInfoByPetID(characterBattlePet)) .. ' configured on a character level.')
    else 
        self.Print(select(8, C_PetJournalGetPetInfoByPetID(M.db.companion)) .. ' configured on a profile level.')
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
    self:RegisterChatCommand('rinbrissetpetid', 'SetPetID')
    self:RegisterChatCommand('rinbrisgetpetid', 'GetPetID')
    self:RegisterChatCommand('rinbrischeckpetid', 'CheckPetID')
    self:RegisterChatCommand('rinbrismountid', 'GetMountID')
    self:RegisterChatCommand('rinbriszoneid', 'ChatCommand_ShowZoneID')
end