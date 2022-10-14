local Rinbris = select(2, ...)
Rinbris[2] = Rinbris[1].Libs.ACL:GetLocale('Rinbris', GetLocale())
local E = unpack(Rinbris)

-- Lua APIs
local strsplit, strjoin = strsplit, strjoin
local ipairs, pairs = ipairs, pairs
local tonumber = tonumber
local format = format
local xpcall = xpcall
local type = type
local wipe = wipe

-- WoW APIs
local _G = _G
local UnitGUID = UnitGUID

--Constants
E.title = format('%s%s|r', '|cff00ff00', 'Rinbris')
E.version = tonumber(GetAddOnMetadata('Rinbris', 'Version'))
E.toc = tonumber(GetAddOnMetadata('Rinbris', 'X-Interface'))
E.myfaction, E.myLocalizedFaction = UnitFactionGroup('player')
E.mylevel = UnitLevel('player')
E.myLocalizedClass, E.myclass, E.myClassID = UnitClass('player')
E.myLocalizedRace, E.myrace = UnitRace('player')
E.myname = UnitName('player')
E.myrealm = GetRealmName()
E.mynameRealm = format('%s - %s', E.myname, E.myrealm)
E.myspec = GetSpecialization()

E.RegisteredModules = {}

function E.Print(...)
    _G.DEFAULT_CHAT_FRAME:AddMessage(strjoin('', '|cff00ff00', 'Rinbris:|r ', ...))
end

function E:CopyTable(current, default)
	if type(current) ~= 'table' then
		current = {}
	end

	if type(default) == 'table' then
		for option, value in pairs(default) do
			current[option] = (type(value) == 'table' and self:CopyTable(current[option], value)) or value
		end
	end

	return current
end

do
	local function errorhandler(err)
		return _G.geterrorhandler()(err)
	end

	function E.CallLoadFunc(func, ...)
		xpcall(func, errorhandler, ...)
	end
end

function E:CallLoadedModule(obj, silent, object, index)
	local name, func
	if type(obj) == 'table' then
		name, func = unpack(obj)
	else
		name = obj
	end

	local module = name and self:GetModule(name, silent)

	if not module then
		return
	end

	if func and type(func) == 'string' then
		self.CallLoadFunc(module[func], module)
	elseif func and type(func) == 'function' then
		self.CallLoadFunc(func, module)
	elseif module.Initialize then
		self.CallLoadFunc(module.Initialize, module)
	end

	if object and index then
		object[index] = nil
	end
end

function E:RegisterModule(name, func)
	if self.initialized then
		self:CallLoadedModule((func and {name, func}) or name)
	else
		self.RegisteredModules[#self.RegisteredModules + 1] = (func and {name, func}) or name
	end
end

function E:InitializeModules()
	for index, object in ipairs(self.RegisteredModules) do
		self:CallLoadedModule(object, true, self.RegisteredModules, index)
	end
end

-- function E:DBConversionsDF()
-- end

function E:DBConversions()
    if self.db.dbConverted ~= self.version then
        self.db.dbConverted = self.version

        -- self:DBConversionsDF()
    end
end

function E:UpdateDB()
	self.private = self.charSettings.profile
	self.global = self.data.global
	self.db = self.data.profile

	self:DBConversions()
end

function E:Initialize()
	wipe(self.db)
	wipe(self.global)
	wipe(self.private)

	local playerGUID = UnitGUID('player')
	local _, serverID = strsplit('-', playerGUID)
	self.serverID = tonumber(serverID)
	self.myguid = playerGUID

	self.data = self.Libs.AceDB:New('RinbrisDB', self.DF, true)
	self.data.RegisterCallback(E, 'OnProfileChanged', 'OnProfileChanged')
	self.data.RegisterCallback(E, 'OnProfileCopied', 'OnProfileCopied')
	self.data.RegisterCallback(E, 'OnProfileReset', 'OnProfileReset')
	self.charSettings = self.Libs.AceDB:New('RinbrisPrivateDB', self.privateVars)
	self.charSettings.RegisterCallback(E, 'OnProfileChanged', ReloadUI)
	self.charSettings.RegisterCallback(E, 'OnProfileCopied', ReloadUI)
	self.charSettings.RegisterCallback(E, 'OnProfileReset', 'OnPrivateProfileReset')
	self.private = self.charSettings.profile
	self.global = self.data.global
	self.db = self.data.profile
	self.Libs.DualSpec:EnhanceDatabase(self.data, 'Rinbris')

	self:DBConversions()
    self:LoadCommands()
    self:InitializeModules()

	E.initialized = true
end