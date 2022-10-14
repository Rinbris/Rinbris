local E = unpack(select(2, ...))

-- Lua APIs
local select = select

-- WoW APIs
local C_PetJournal_GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local C_PetJournal_GetPetInfoByPetID = C_PetJournal.GetPetInfoByPetID

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
        self.Print(select(8, C_PetJournal_GetPetInfoByPetID(E.db.misc.companion)) .. ' configured on a profile level.')
    end
end

function E:LoadCommands()
    self:RegisterChatCommand('rinbrissetpetid', 'SetCurrentPetID')
    self:RegisterChatCommand('rinbrisgetpetid', 'GetPetID')
    self:RegisterChatCommand('rinbrischeckpetid', 'CheckPetID')
end