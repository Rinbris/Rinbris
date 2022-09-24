local E, L, V, P, G = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Blizzard Globals
local C_PetJournal_GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local C_PetJournal_SummonPetByGUID = C_PetJournal.SummonPetByGUID

local InCombatLockdown = InCombatLockdown

local IsStealthed = IsStealthed

function M.PLAYER_STARTED_MOVING()
    if not InCombatLockdown('player') and not IsStealthed() and C_PetJournal_GetSummonedPetGUID() ~= M.db.companion then
        C_PetJournal_SummonPetByGUID(M.db.companion)
    end
end

function M:LoadKeepBattlePet()
    self:RegisterEvent('PLAYER_STARTED_MOVING')
end