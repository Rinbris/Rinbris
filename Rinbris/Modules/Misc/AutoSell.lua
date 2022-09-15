local E, L, V, P, G = unpack(Rinbris)
local AS = E:GetModule('AutoSell')

local GetContainerNumSlots, GetContainerItemInfo, UseContainerItem = GetContainerNumSlots, GetContainerItemInfo, UseContainerItem

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
    self.Initialized = true

    self:RegisterEvent('MERCHANT_SHOW')
end

E:RegisterModule(AS:GetName())