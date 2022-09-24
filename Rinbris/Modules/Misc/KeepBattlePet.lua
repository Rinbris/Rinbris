local E = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local select = select

-- Blizzard Globals
local C_PetJournal_GetSummonedPetGUID = C_PetJournal.GetSummonedPetGUID
local C_PetJournal_SummonPetByGUID = C_PetJournal.SummonPetByGUID

local InCombatLockdown = InCombatLockdown
local IsInInstance = IsInInstance
local IsStealthed = IsStealthed


if select(2, IsInInstance()) == 'pvp' then 
    RepopMe()
end

function M.PLAYER_STARTED_MOVING()
    if not InCombatLockdown('player') and select(2, IsInInstance()) ~= 'pvp' and not IsStealthed() and C_PetJournal_GetSummonedPetGUID() ~= M.db.companion then
        C_PetJournal_SummonPetByGUID(M.db.companion)
    end
end

function M:LoadKeepBattlePet()
    self:RegisterEvent('PLAYER_STARTED_MOVING')
end


local instanceType = select(2, IsInInstance())