-- Lua APIs
local type = type

-- WoW APIs
local _G = _G

_G.BINDING_HEADER_RINBRIS = GetAddOnMetadata(..., 'Title')

local AceAddon, AceAddonMinor = _G.LibStub('AceAddon-3.0')

local addonName, Engine = ...
local E = AceAddon:NewAddon(addonName, 'AceConsole-3.0', 'AceEvent-3.0')
E.DF = { profile = {}, global = {} }
E.privateVars = { profile = {} }
E.Options = { type = 'group', args = {}, childGroups = 'Rinbris_HiddenTree' }

Engine[1] = E                     -- E, Engine
Engine[2] = {}                    -- L, Locales
Engine[3] = E.privateVars.profile -- V, PrivateDB
Engine[4] = E.DF.profile          -- P, ProfileDB
Engine[5] = E.DF.global           -- G, GlobalDB
_G[addonName] = Engine

E.AutoRepair = E:NewModule('AutoRepair','AceEvent-3.0')
E.AutoSell = E:NewModule('AutoSell','AceEvent-3.0')
E.Blizzard = E:NewModule('Blizzard','AceEvent-3.0')
E.Chat = E:NewModule('Chat','AceEvent-3.0')
E.Misc = E:NewModule('Misc','AceEvent-3.0')
E.Profiles = E:NewModule('Profiles','AceEvent-3.0')

do
    E.Libs = {}
    E.LibsMinor = {}
	function E:AddLib(name, major, minor)
		if not name then
            return
        end

		if type(major) == 'table' and type(minor) == 'number' then
			self.Libs[name], self.LibsMinor[name] = major, minor
		else
			self.Libs[name], self.LibsMinor[name] = _G.LibStub(major, minor)
		end
	end

    E:AddLib('AceAddon', AceAddon, AceAddonMinor)
    E:AddLib('AceDB', 'AceDB-3.0')
    E:AddLib('ACL', 'AceLocale-3.0')
    E:AddLib('DualSpec', 'LibDualSpec-1.0')
    E:AddLib('LSM', 'LibSharedMedia-3.0')
end

function E:OnEnable()
    self:Initialize()
end

function E:OnInitialize()
    if not RinbrisCharacterDB then
        RinbrisCharacterDB = {}
    end

    self.db = self:CopyTable({}, self.DF.profile)
    self.global = self:CopyTable({}, self.DF.global)
    self.private = self:CopyTable({}, self.privateVars.profile)

    if RinbrisDB then
        if RinbrisDB.global then
            self:CopyTable(self.global, RinbrisDB.global)
        end

        local key = RinbrisDB.profileKeys and RinbrisDB.profileKeys[self.myNameRealm]
        if key and RinbrisDB.profiles and RinbrisDB.profiles[key] then
            self:CopyTable(self.db, RinbrisDB.profiles[key])
        end
    end

	if RinbrisPrivateDB then
		local key = RinbrisPrivateDB.profileKeys and RinbrisPrivateDB.profileKeys[E.mynameRealm]
		if key and RinbrisPrivateDB.profiles and RinbrisPrivateDB.profiles[key] then
			E:CopyTable(E.private, RinbrisPrivateDB.profiles[key])
		end
	end
end

function E:OnProfileChanged(event)
    if event == 'OnProfileChanged' then
        self:UpdateDB()
    end
end

function E:OnProfileReset(event)
    if event == 'OnProfileReset' then
        self:UpdateDB()
    end
end

function E:OnProfileCopied(event)
    if event == 'OnProfileCopied' then
        self:UpdateDB()
    end
end

function E:OnPrivateProfileReset(event)
    if event == 'OnProfileReset' then
        self:UpdateDB()
    end
end