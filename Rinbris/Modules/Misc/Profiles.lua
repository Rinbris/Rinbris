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

function PR.PLAYER_ENTERING_WORLD()
    for i = 1, GetNumAddOns() do
        local addonName = GetAddOnInfo(i)

        if IsAddOnLoaded(i) and (addonName == 'Dominos' or addonName == 'Grid2' ) then
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