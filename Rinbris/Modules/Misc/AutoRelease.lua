local E = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local select = select

-- Blizzard Globals
local IsInInstance = IsInInstance

local RepopMe = RepopMe

function M.PLAYER_DEAD()
    if select(2, IsInInstance()) == 'pvp' then 
        RepopMe()
    end
end

function M:LoadAutoRelease()
    self:RegisterEvent('PLAYER_DEAD')
end