local E = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local select = select

-- WoW APIs
local C_PetJournal_GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local C_PetJournal_SummonPetByGUID = C_PetJournal.SummonPetByGUID

local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local IsStealthed = IsStealthed

function M.PLAYER_STARTED_MOVING()
    local battlePet = RinbrisCharacterDB.battlePet or M.db.companion
    if not InCombatLockdown('player') and select(2, IsInInstance()) ~= 'pvp' and not IsStealthed() and C_PetJournal_GetSummonedPetGUID() ~= battlePet then
        C_PetJournal_SummonPetByGUID(battlePet)
    end
end

function M:LoadKeepBattlePet()
    self:RegisterEvent('PLAYER_STARTED_MOVING')
end

local instanceType = select(2, IsInInstance())