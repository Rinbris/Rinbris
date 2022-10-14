local E = unpack(select(2, ...))

-- Lua APIs
local tonumber = tonumber
local strjoin = strjoin
local select = select
local pairs = pairs

-- WoW APIs
local C_PetJournal_GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local C_PetJournal_GetPetInfoByPetID = C_PetJournal.GetPetInfoByPetID
-- local C_MountJournal_GetMountInfoByID = C_MountJournal.GetMountInfoByID

-- local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit
-- local C_Map_GetMapInfo = C_Map.GetMapInfo

-- function E:SetPetID(petID) -- TODO: Is it still usefull ?
--     if petID == nil then
--         return
--     end

--     local name = select(8, C_PetJournal_GetPetInfoByPetID(petID))
--     if name then
--         RinbrisCharacterDB.battlePet = petID
--         self.Print(name .. ' configured.')
--     end
-- end

function E:SetCurrentPetID()
    local summonedPetGUID = C_PetJournal_GetSummonedPetGUID()
    if summonedPetGUID then
        local name = select(8, C_PetJournal_GetPetInfoByPetID(summonedPetGUID))
        if name then
            RinbrisCharacterDB.battlePet = summonedPetGUID
            self.Print(name .. ' configured.')
        end
    end
end

function E:GetPetID()
    local summonedPetGUID = C_PetJournal_GetSummonedPetGUID()
    if summonedPetGUID then
        self.Print('Current petID is : ' .. summonedPetGUID)
    end
end

function E:CheckPetID()
    local characterBattlePet = RinbrisCharacterDB.battlePet
    if characterBattlePet then
        self.Print(select(8, C_PetJournal_GetPetInfoByPetID(characterBattlePet)) .. ' configured on a character level.')
    else 
        self.Print(select(8, C_PetJournal_GetPetInfoByPetID(M.db.companion)) .. ' configured on a profile level.')
    end
end

-- function E:ChatCommand_GetMountID(spellID)
--     if spellID == nil then
--         return
--     end

--     local mountIDs = C_MountJournalGetMountIDs
--     for _, mountID in pairs(mountIDs) do
--         local mountName, mountSpellID = C_MountJournal_GetMountInfoByID(mountID)

--         if mountSpellID == tonumber(spellID) then
--             self.Print(strjoin(' ', mountName, mountID))
--         end
--     end
-- end

-- function E:ChatCommand_ShowZoneID()
--     local id = C_Map_GetBestMapForUnit('player')
--     self.Print(strjoin(' - ', id, C_Map_GetMapInfo(id).name))
-- end

function E:LoadCommands()
    -- self:RegisterChatCommand('rinbrissetpetid', 'SetPetID')
    self:RegisterChatCommand('rinbrissetpetid', 'SetCurrentPetID')
    self:RegisterChatCommand('rinbrisgetpetid', 'GetPetID')
    self:RegisterChatCommand('rinbrischeckpetid', 'CheckPetID')
    -- self:RegisterChatCommand('rinbrismountid', 'GetMountID')
    -- self:RegisterChatCommand('rinbriszoneid', 'ChatCommand_ShowZoneID')
end