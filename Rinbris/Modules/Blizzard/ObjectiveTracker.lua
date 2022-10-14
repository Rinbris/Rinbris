local E = unpack(Rinbris)
local B = E:GetModule('Blizzard')

-- Lua APIs
local select = select

-- WoW APIs
local IsInInstance = IsInInstance

local C_Timer_After = C_Timer.After

local C_QuestLog_RemoveQuestWatch = C_QuestLog.RemoveQuestWatch
local C_QuestLog_IsComplete = C_QuestLog.IsComplete

local ObjectiveTracker_Collapse = ObjectiveTracker_Collapse
local ObjectiveTracker_Expand = ObjectiveTracker_Expand

function B.QUEST_WATCH_UPDATE(_, _, questID)
    C_Timer_After(0.5, function()
        if C_QuestLog_IsComplete(questID) then
            C_QuestLog_RemoveQuestWatch(questID)
        end
    end)
end

function B.PLAYER_ENTERING_WORLD()
    local instanceType = select(2, IsInInstance())
    if not instanceType then return end

    if instanceType == 'pvp' or instanceType == 'arena' then
        ObjectiveTrackerFrame:Hide()
    elseif instanceType == 'party' or instanceType == 'raid' or instanceType == 'scenario' then
        ObjectiveTrackerFrame:Show()
        ObjectiveTracker_Collapse()
    else
        ObjectiveTrackerFrame:Show()
        ObjectiveTracker_Expand()
    end
end

function B:UpdateObjectiveTracker()
    ObjectiveTrackerFrame:SetScale(self.db.ObjectiveTrackerScale)

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('QUEST_WATCH_UPDATE')
end