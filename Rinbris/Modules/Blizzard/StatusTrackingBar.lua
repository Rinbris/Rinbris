local E = unpack(Rinbris)
local B = E:GetModule('Blizzard')

function B.StatusTrackingBar()
    StatusTrackingBarManager:UnregisterAllEvents()
    StatusTrackingBarManager:Hide()
end