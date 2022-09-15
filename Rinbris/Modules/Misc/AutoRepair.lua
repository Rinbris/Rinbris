local E, L, V, P, G = unpack(Rinbris)
local AR = E:GetModule('AutoRepair')

local select = select
local IsShiftKeyDown, CanMerchantRepair, GetRepairAllCost, IsInGuild, CanGuildBankRepair, RepairAllItems = IsShiftKeyDown, CanMerchantRepair, GetRepairAllCost, IsInGuild, CanGuildBankRepair, RepairAllItems

function AR.MERCHANT_SHOW()
    if not IsShiftKeyDown() and CanMerchantRepair() then
        if select(2, GetRepairAllCost()) then
            if IsInGuild() and CanGuildBankRepair() then
                RepairAllItems(1)
                RepairAllItems()
            else
                RepairAllItems()
            end
        end
    end
end

function AR:Initialize()
    self.Initialized = true

    self:RegisterEvent('MERCHANT_SHOW')
end

E:RegisterModule(AR:GetName())
