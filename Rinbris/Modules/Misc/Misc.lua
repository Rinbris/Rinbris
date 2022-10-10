local E = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local pairs = pairs

-- WoW APIs
local MuteSoundFile = MuteSoundFile
local DisableAddOn = DisableAddOn

local blacklistSound = {
    25152, -- SPELL_Vine_CreatureLoop
    7518, -- SPELL_EmoteSpellKneel
    146217, -- Emitter_83_Visions_Stormwnd_StagingArea_OldGodWind_Loop_01
    568252, -- sound/spells/summongyrocopter.ogg
    551383, -- sound/creature/gyrocopter/gyrocopterstand.ogg
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
    600293, -- sound/creature/goblintrike/veh_goblintrike_drive_loop_01.ogg
    550821, -- sound/creature/goblinshredder/goblinshredderattackc.ogg
    550822, -- sound/creature/goblinshredder/goblinshredderwoundb.ogg
    550823, -- sound/creature/goblinshredder/goblinshredderaggro.ogg
    550824, -- sound/creature/goblinshredder/goblinshredderloop.ogg
    550825, -- sound/creature/goblinshredder/goblinshredderwoundcrit.ogg
    550826, -- sound/creature/goblinshredder/goblinshredderattackb.ogg
    550827, -- sound/creature/goblinshredder/goblinshredderattacka.ogg
    550828, -- sound/creature/goblinshredder/goblinshredderwoundc.ogg
    550829, -- sound/creature/goblinshredder/goblinshredderdeatha.ogg
    550830, -- sound/creature/goblinshredder/goblinshredderwounda.ogg
    550831, -- sound/creature/goblinshredder/goblinshredderpreaggro.ogg
    893935, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_01.ogg
    893937, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_02.ogg
    893939, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_03.ogg
    893941, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_04.ogg
    893943, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_05.ogg
    893945, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_06.ogg
    893947, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_07.ogg
    893949, -- sound/creature/goblinshredder/footstep_goblinshreddermount_general_08.ogg
    898320, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightbackward_lp.ogg
    898322, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightidle_lp.ogg
    898324, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightleftright_lp.ogg
    898326, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightrun_lp.ogg
    898328, -- sound/creature/goblinshredder/mon_goblinshredder_mount_idlestand_lp.ogg
    898330, -- sound/creature/goblinshredder/mon_goblinshredder_mount_swim_lp.ogg
    898428, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightstart_01.ogg
    898430, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightstart_02.ogg
    898432, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightstart_03.ogg
    898434, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightstart_04.ogg
    898436, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightstart_05.ogg
    898438, -- sound/creature/goblinshredder/mon_goblinshredder_mount_special_01.ogg
    898440, -- sound/creature/goblinshredder/mon_goblinshredder_mount_special_02.ogg
    898442, -- sound/creature/goblinshredder/mon_goblinshredder_mount_special_03.ogg
    898444, -- sound/creature/goblinshredder/mon_goblinshredder_mount_special_04.ogg
    898446, -- sound/creature/goblinshredder/mon_goblinshredder_mount_special_05.ogg
    899109, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_01.ogg
    899111, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_010.ogg
    899113, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_02.ogg
    899115, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_03.ogg
    899117, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_04.ogg
    899119, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_05.ogg
    899121, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_06.ogg
    899123, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_07.ogg
    899125, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_08.ogg
    899127, -- sound/creature/goblinshredder/mon_goblinshredder_mount_gears_09.ogg
    899129, -- sound/creature/goblinshredder/mon_goblinshredder_mount_land_01.ogg
    899131, -- sound/creature/goblinshredder/mon_goblinshredder_mount_land_02.ogg
    899133, -- sound/creature/goblinshredder/mon_goblinshredder_mount_land_03.ogg
    899135, -- sound/creature/goblinshredder/mon_goblinshredder_mount_land_04.ogg
    899137, -- sound/creature/goblinshredder/mon_goblinshredder_mount_land_05.ogg
    899139, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshift_01.ogg
    899141, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshift_02.ogg
    899143, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshift_03.ogg
    899145, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshift_04.ogg
    899147, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshift_05.ogg
    899149, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshift_06.ogg
    899247, -- sound/creature/goblinshredder/mon_goblinshredder_mount_flightend.ogg
    901303, -- sound/creature/goblinshredder/mon_goblinshredder_mount_swimwaterlayer_lp.ogg
    903314, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshiftnoboom_01.ogg
    903316, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshiftnoboom_02.ogg
    903318, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshiftnoboom_03.ogg
    903320, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshiftnoboom_04.ogg
    903322, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshiftnoboom_05.ogg
    903324, -- sound/creature/goblinshredder/mon_goblinshredder_mount_takeflightgearshiftnoboom_06.ogg
    1049453, -- sound/creature/goblinshredderpet/pet_goblinshredder_death_01.ogg
    1049454, -- sound/creature/goblinshredderpet/pet_goblinshredder_death_02.ogg
    1049455, -- sound/creature/goblinshredderpet/pet_goblinshredder_death_03.ogg
    1049456, -- sound/creature/goblinshredderpet/pet_goblinshredder_death_04.ogg
    1049457, -- sound/creature/goblinshredderpet/pet_goblinshredder_death_05.ogg
    1049458, -- sound/creature/goblinshredderpet/pet_goblinshredder_stand1_01.ogg
    1049459, -- sound/creature/goblinshredderpet/pet_goblinshredder_stand1_02.ogg
    1049460, -- sound/creature/goblinshredderpet/pet_goblinshredder_stand1_03.ogg
    1049461, -- sound/creature/goblinshredderpet/pet_goblinshredder_wound_01.ogg
    1049462, -- sound/creature/goblinshredderpet/pet_goblinshredder_wound_02.ogg
    1049463, -- sound/creature/goblinshredderpet/pet_goblinshredder_wound_03.ogg
    1049464, -- sound/creature/goblinshredderpet/pet_goblinshredder_wound_04.ogg
    1049465, -- sound/creature/goblinshredderpet/pet_goblinshredder_wound_05.ogg
    1049466, -- sound/creature/goblinshredderpet/pet_goblinshredder_wound_06.ogg
    1049467, -- sound/creature/goblinshredderpet/pet_goblinshredder_wound_07.ogg
    1049468, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_01.ogg
    1049469, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_02.ogg
    1049470, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_03.ogg
    1049471, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_04.ogg
    1049472, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_05.ogg
    1049473, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_06.ogg
    1049474, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_07.ogg
    1049475, -- sound/creature/goblinshredderpet/pet_goblinshredder_clickables_08.ogg
}

function M.MuteUselessSound()
    for _, s in pairs(blacklistSound) do
        MuteSoundFile(s)
    end
end

function M.DominosProfile()
    if Dominos then
        Dominos:SetProfile('default')
    end
end

function M.DetailsProfile()
    if _detalhes then
        _detalhes:SetProfile('default')
    end
end

function M:Initialize()
    if not E.private.misc.enable then
        return
    end

    self.db = E.db.misc

    UIParent:SetScale(E.global.general.UIScale)

    self.MuteUselessSound()
    self.DominosProfile()
    self.DetailsProfile()
    self:LoadAutoRelease()
    self:LoadAutoRepair()
    self:LoadKeepBattlePet()
    self:LoadLoot()
    
    self.Initialized = true
end

E:RegisterModule(M:GetName())
