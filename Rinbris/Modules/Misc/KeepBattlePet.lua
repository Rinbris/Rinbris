local E, L, V, P, G = unpack(Rinbris)
local PL = E:GetModule('KeepBattlePet')

local InCombatLockdown, IsStealthed = InCombatLockdown, IsStealthed
local C_PetJournal_GetSummonedPetGUID, C_PetJournal_SummonPetByGUID = C_PetJournal.GetSummonedPetGUID, C_PetJournal.SummonPetByGUID

function PL.PLAYER_STARTED_MOVING()
    if InCombatLockdown('player') or IsStealthed() then return end
    if C_PetJournal_GetSummonedPetGUID() ~= 'BattlePet-0-00000F8DBF00' then
        C_PetJournal_SummonPetByGUID('BattlePet-0-00000F8DBF00')
    end
end

function PL:Initialize()
    self.Initialized = true

    self:RegisterEvent('PLAYER_STARTED_MOVING')
end

E:RegisterModule(PL:GetName())
