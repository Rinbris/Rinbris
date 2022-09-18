local E, L, V, P, G = unpack(Rinbris)
local B = E:GetModule('Blizzard')

local hooksecurefunc = hooksecurefunc

function B.PLAYER_REGEN_ENABLED()
    GameTooltip:SetScript('OnShow',GameTooltip.Show)
end

function B.PLAYER_REGEN_DISABLED()
    GameTooltip:SetScript('OnShow',GameTooltip.Hide)
    if GameTooltip:IsShown() then
        GameTooltip:Hide()
    end
end

function B:UpdateGameTooltip()
    hooksecurefunc('GameTooltip_SetDefaultAnchor', function(tooltip, parent)
        if tooltip and parent then
            local a, _, c  = tooltip:GetPoint()
            if a ~= 'BOTTOMRIGHT' or c ~= 'BOTTOMRIGHT' then
                tooltip:ClearAllPoints()
            end
            tooltip:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', 0, 0)
        end
    end)

    self:RegisterEvent('PLAYER_REGEN_ENABLED')
    self:RegisterEvent('PLAYER_REGEN_DISABLED')
end