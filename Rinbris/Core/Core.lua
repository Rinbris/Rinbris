local Rinbris = select(2, ...)
Rinbris[2] = Rinbris[1].Libs.ACL:GetLocale('Rinbris', GetLocale())
local E = unpack(Rinbris)

-- Lua APIs
local strjoin = strjoin
local ipairs, pairs = ipairs, pairs
local format = format
local xpcall = xpcall
local select = select
local type = type
local wipe = wipe

-- WoW APIs
local _G = _G

--Constants
E.myClassID = select(3, UnitClass('player'))
E.myRealmName = format('%s - %s', UnitName('player'), GetRealmName())

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

function E:DBConversions()
    if self.db.dbConverted ~= self.version then
        self.db.dbConverted = self.version
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