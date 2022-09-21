local E, L, V, P, G = unpack(Rinbris)
local M = E:GetModule('Misc')

local select = select 

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

function M:OnLootClosed()
    LootFrame:Close()
end

function M:LoadLoot()
    self:RegisterEvent('LOOT_READY', self.OnLootReady)
    self:RegisterEvent('LOOT_OPENED', self.OnLootReady)
    self:RegisterEvent('LOOT_CLOSED', self.OnLootClosed)
end