local E = unpack(Rinbris)
local M = E:GetModule('Misc')

-- Lua APIs
local select = select

-- Blizzard Globals
local IsShiftKeyDown = IsShiftKeyDown
local CanMerchantRepair = CanMerchantRepair
local GetRepairAllCost = GetRepairAllCost
local IsInGuild = IsInGuild
local CanGuildBankRepair = CanGuildBankRepair
local RepairAllItems = RepairAllItems

function M.MERCHANT_SHOW()
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

function M:LoadAutoRepair()
    self:RegisterEvent('MERCHANT_SHOW')
end
