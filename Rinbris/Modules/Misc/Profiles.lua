local E = unpack(Rinbris)
local PR = E:GetModule('Profiles')

-- Lua APIs
local pairs = pairs
local type = type 

-- WoW APIs
local _G = _G

local GetNumAddOns = GetNumAddOns
local GetAddOnInfo = GetAddOnInfo
local IsAddOnLoaded = IsAddOnLoaded

local GetNumSpecializations = GetNumSpecializations
local GetSpecializationInfo = GetSpecializationInfo

local specData = {
    [1] = { -- Warrior
        [71] = 'DPS', -- Arms
        [72] = 'DPS', -- Fury
        [73] = 'TANK' -- Protection
    },
    [2] = { -- Paladin
        [65] = 'HEAL', -- Holy
        [66] = 'TANK', -- Protection
        [70] = 'DPS' -- Retribution
    },
    [3] = { -- Hunter
        [253] = 'DPS', -- Beast Mastery
        [254] = 'DPS', -- Marksmanship
        [255] = 'DPS' -- Survival
    },
    [4] = { -- Rogue
        [259] = 'DPS', -- Assassination
        [260] = 'DPS', -- Outlaw
        [261] = 'DPS' -- Subtlety
    },
    [5] = { -- Priest
        [256] = 'HEAL', -- Discipline
        [257] = 'HEAL', -- Holy
        [259] = 'DPS' -- Shadow
    },
    [6] = { -- DeathKnight
        [250] = 'DPS', -- Blood
        [251] = 'DPS', -- Frost
        [252] = 'DPS' -- Unholy
    },
    [7] = { -- Shaman
        [262] = 'DPS', -- Elemental
        [263] = 'DPS', -- Enhancement
        [264] = 'HEAL' -- Restoration
    },
    [8] = { -- Mage
        [62] = 'DPS', -- Arcane
        [63] = 'DPS', -- Fire
        [67] = 'DPS' -- Frost
    },
    [9] = { -- Warlock
        [265] = 'DPS', -- Affliction
        [266] = 'DPS', -- Demonology
        [267] = 'DPS' -- Destruction
    },
    [10] = { -- Monk
        [268] = 'TANK', -- Brewmaster
        [269] = 'DPS', -- Windwalker
        [270] = 'HEAL' -- Mistweaver
    },
    [11] = { -- Druid
        [102] = 'DPS', -- Balance
        [103] = 'DPS', -- Feral
        [104] = 'TANK', -- Guardian
        [105] = 'HEAL' -- Restoration
    },
    [12] = { -- Demon Hunter
        [577] = 'DPS', -- Havoc
        [581] = 'TANK' -- Vengeance
    },
    [13] = { -- Evoker
        [1467] = 'DPS', -- Devastation
        [1468] = 'HEAL' -- Preservation
    }
}

function PR.PLAYER_ENTERING_WORLD()
    for i = 1, GetNumAddOns() do
        local addonName = GetAddOnInfo(i)

        if IsAddOnLoaded(i) then
            if (addonName == 'Dominos' or addonName == 'Grid2' ) then
                local addon = _G[addonName]
                if type(addon) == "table" and type(addon.db) == "table" and addon.db.GetProfiles then
                    local current = addon.db:GetCurrentProfile()
                    if current ~= 'default' then
                        addon.db:SetProfile('default')
                    end
    
                    for _, profileName in pairs(addon.db:GetProfiles()) do
                        if profileName ~= 'default' then
                            addon.db:DeleteProfile(profileName)
                        end
                    end
                end
            elseif addonName == 'ShadowedUnitFrames' then
                local addon = _G['ShadowUF']
                if type(addon) == "table" and type(addon.db) == "table" and addon.db.GetProfiles then
                    if UnitLevel('player') > 9 then
                        if not addon.db:IsDualSpecEnabled() then
                            addon.db:SetDualSpecEnabled(true)
                        end
                        
                        for specIndex = 1, GetNumSpecializations() do                        
                            local desiredProfileName = specData[E.myClassID][GetSpecializationInfo(specIndex)]
                            if desiredProfileName then
                                local currentDualSpec = addon.db:GetDualSpecProfile(specIndex)
                                if currentDualSpec ~= desiredProfileName then
                                    addon.db:SetDualSpecProfile(desiredProfileName, specIndex)
                                end
                            end
                        end
                    else
                        local current = addon.db:GetCurrentProfile()
                        if current ~= 'DPS' then
                            addon.db:SetProfile('DPS')
                        end
                    end
                end
            end
        end
    end
end

function PR:Initialize()
    if not E.private.misc.enable then
        return
    end

    self.db = E.db.profiles

    self:RegisterEvent('PLAYER_ENTERING_WORLD')

    self.Initialized = true
end

E:RegisterModule(PR:GetName())