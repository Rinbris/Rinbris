local E = unpack(Rinbris)
local B = E:GetModule('Blizzard')

function B:Initialize()
    if not E.private.blizzard.enable then
        return
    end

    self.db = E.db.blizzard

    self:UpdateObjectiveTracker()
    self:UpdateGameTooltip()
    self:StatusTrackingBar()
    self:UpdateMinimap()

    self.Initialized = true
end

E:RegisterModule(B:GetName())
