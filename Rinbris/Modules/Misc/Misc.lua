local E = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local pairs = pairs

-- WoW APIs
local MuteSoundFile = MuteSoundFile
local DisableAddOn = DisableAddOn

local blacklistSound = {
    569854, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclewalkrun.ogg
    569858, -- sound/vehicles/motorcyclevehicle/motorcyclevehicleattackthrown.ogg
    569859, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclestand.ogg
    569861, -- sound/vehicles/motorcyclevehicle/motorcyclevehicleloadthrown.ogg
    569856, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclejumpstart1.ogg
    569862, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclejumpstart2.ogg
    569860, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclejumpstart3.ogg
    569863, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclejumpend1.ogg
    569855, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclejumpend3.ogg
    569857, -- sound/vehicles/motorcyclevehicle/motorcyclevehiclejumpend2.ogg
    598748, -- sound/vehicles/vehicle_ground_gearshift_1.ogg
    598736, -- sound/vehicles/vehicle_ground_gearshift_2.ogg
    569852, -- sound/vehicles/vehicle_ground_gearshift_3.ogg
    598745, -- sound/vehicles/vehicle_ground_gearshift_4.ogg
    569845, -- sound/vehicles/vehicle_ground_gearshift_5.ogg
    1663845, -- sound/creature/manaray/mon_manaray_chuff_01.ogg
    1663846, -- sound/creature/manaray/mon_manaray_chuff_02.ogg
    1663826, -- sound/creature/manaray/mon_manaray_chuff_03.ogg
    1663827, -- sound/creature/manaray/mon_manaray_chuff_04.ogg
    1663828, -- sound/creature/manaray/mon_manaray_chuff_05.ogg
    1663829, -- sound/creature/manaray/mon_manaray_chuff_06.ogg
    1663830, -- sound/creature/manaray/mon_manaray_chuff_07.ogg
    1663831, -- sound/creature/manaray/mon_manaray_chuff_08.ogg
    1663835, -- sound/creature/manaray/mon_manaray_summon_01.ogg
    1663836, -- sound/creature/manaray/mon_manaray_summon_02.ogg
    1323566, -- sound/creature/druidcat/mon_dr_catform_attack01.ogg
    1323567, -- sound/creature/druidcat/mon_dr_catform_attack02.ogg
    1323568, -- sound/creature/druidcat/mon_dr_catform_attack03.ogg
    1323569, -- sound/creature/druidcat/mon_dr_catform_attack04.ogg
    1323570, -- sound/creature/druidcat/mon_dr_catform_attack05.ogg
    1323571, -- sound/creature/druidcat/mon_dr_catform_attack06.ogg
    1323572, -- sound/creature/druidcat/mon_dr_catform_attack07.ogg
    1323573, -- sound/creature/druidcat/mon_dr_catform_attack08.ogg
    1323574, -- sound/creature/druidcat/mon_dr_catform_spellattack01.ogg
    1323575, -- sound/creature/druidcat/mon_dr_catform_spellattack02.ogg
    1323576, -- sound/creature/druidcat/mon_dr_catform_spellattack03.ogg
    1323577, -- sound/creature/druidcat/mon_dr_catform_spellattack04.ogg
    1323578, -- sound/creature/druidcat/mon_dr_catform_spellattack05.ogg
    1324558, -- sound/creature/druidcat/mon_dr_catform_wound01.ogg
    1324559, -- sound/creature/druidcat/mon_dr_catform_wound02.ogg
    1324560, -- sound/creature/druidcat/mon_dr_catform_wound03.ogg
    1324561, -- sound/creature/druidcat/mon_dr_catform_wound04.ogg
    1324562, -- sound/creature/druidcat/mon_dr_catform_wound05.ogg
    1324563, -- sound/creature/druidcat/mon_dr_catform_wound06.ogg
    1324564, -- sound/creature/druidcat/mon_dr_catform_wound07.ogg
    1324565, -- sound/creature/druidcat/mon_dr_catform_wound08.ogg
    1324566, -- sound/creature/druidcat/mon_dr_catform_woundcrit01.ogg
    1324567, -- sound/creature/druidcat/mon_dr_catform_woundcrit02.ogg
    1324568, -- sound/creature/druidcat/mon_dr_catform_woundcrit03.ogg
    1324569, -- sound/creature/druidcat/mon_dr_catform_woundcrit04.ogg
    1324570, -- sound/creature/druidcat/mon_dr_catform_woundcrit05.ogg
    600278, -- sound/creature/goblintrike/veh_goblintrike_turn_02.ogg
    600281, -- sound/creature/goblintrike/veh_goblintrike_idle_loop_01.ogg
    600290, -- sound/creature/goblintrike/veh_goblintrike_turn_01.ogg
    600293 -- sound/creature/goblintrike/veh_goblintrike_drive_loop_01.ogg
}

function M.MuteUselessSound()
    for _, s in pairs(blacklistSound) do
        MuteSoundFile(s)
    end
end

function M:Initialize()
    if not E.private.misc.enable then
        return
    end

    self.db = E.db.misc

    UIParent:SetScale(E.global.general.UIScale)

    self.MuteUselessSound()
    self:LoadAutoRelease()
    self:LoadAutoRepair()
    self:LoadKeepBattlePet()
    self:LoadLoot()

    self.Initialized = true
end

E:RegisterModule(M:GetName())
