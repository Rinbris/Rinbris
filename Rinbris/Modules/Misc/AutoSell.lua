local E, L, V, P, G = unpack(Rinbris)
local AS = E:GetModule('AutoSell')

local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemInfo = GetContainerItemInfo
local UseContainerItem = UseContainerItem

function AS.MERCHANT_SHOW()
    local icon, quality
    for bagID = 0, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bagID) do
            icon, _, _, quality = GetContainerItemInfo(bagID, slot)
            if icon and quality == 0 then
                UseContainerItem(bagID, slot)
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