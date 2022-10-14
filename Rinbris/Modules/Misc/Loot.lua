local E = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local select = select

-- WoW APIs
local GetNumLootItems = GetNumLootItems
local GetLootSlotInfo = GetLootSlotInfo

local LootSlot= LootSlot

local function DoLoot()
    local numLootItems  = GetNumLootItems()
    if numLootItems  == 0 then
      return
    end

    for i = 1, numLootItems do
        local _, _, _, locked, _ = select(3, GetLootSlotInfo(i))
        if not locked then
            LootSlot(i)
        end
    end
end

function M.LOOT_READY()
    DoLoot()
end

function M.LOOT_OPENED()
    DoLoot()
end

function M:LoadLoot()
    LootFrame:SetAlpha(0)

    self:RegisterEvent('LOOT_READY')
    self:RegisterEvent('LOOT_OPENED')
end