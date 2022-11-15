local E = unpack(Rinbris)
local B = E:GetModule('Blizzard')

function B.UpdateMinimap()
    MinimapCluster:SetScale(0.87)
    MinimapCluster:SetClampedToScreen(false)
end