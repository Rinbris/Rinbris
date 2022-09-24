local E = unpack(select(2, ...))
local LSM = E.Libs.LSM

local mediaPath = {
	statusbar = [[Interface\AddOns\Rinbris\Media\Statusbar\]],
}

local function AddMedia(type, name, file)
	LSM:Register(type, name, mediaPath[type] .. file)
end

AddMedia('statusbar','RinbrisOnePixel', 'RinbrisOnePixel')
AddMedia('statusbar','RinbrisClean', 'RinbrisClean')