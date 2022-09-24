local E, L, V, P, G = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local select = select 

-- Blizzard Globals
local GetNumLootItems = GetNumLootItems
local GetLootSlotInfo = GetLootSlotInfo

local LootSlot= LootSlot

function M:OnLootReady()
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

function M:LoadLoot()
    LootFrame:SetAlpha(0)

    self:RegisterEvent('LOOT_READY', self.OnLootReady)
    self:RegisterEvent('LOOT_OPENED', self.OnLootReady)
end