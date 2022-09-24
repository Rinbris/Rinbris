local E = unpack(Rinbris)
local AS = E:GetModule('AutoSell')

-- Lua APIs
local select = select

-- WoW APIs
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemInfo = GetContainerItemInfo
local GetItemInfo = GetItemInfo

local UseContainerItem = UseContainerItem

local whitelistItem = {
    -- [55004] = true, -- Wolf Fur Coat
}

local blacklistItem = {
    -- [55004] = true, -- Wolf Fur Coat
}

function AS.MERCHANT_SHOW()
    local icon, locked, quality, itemID, isBound
    for bagID = 0, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bagID) do
            icon, _, locked, quality, _, _, _, _, _, itemID, isBound = GetContainerItemInfo(bagID, slot)
            if not blacklistItem[itemID] and not locked and icon then
                if quality == 0 or whitelistItem[itemID] then
                    UseContainerItem(bagID, slot)
                elseif quality == 1 and isBound then
                    local itemType = select(12, GetItemInfo(itemID))
                    if itemType == 2 or itemType == 4 then -- 2 = Weapon; 4 = Armor
                        UseContainerItem(bagID, slot)
                    end
                end 
            end
        end
    end
end

function AS:Initialize()
    if not E.private.misc.enable then
        return
    end

    self:RegisterEvent('MERCHANT_SHOW')

    self.Initialized = true
end

E:RegisterModule(AS:GetName())