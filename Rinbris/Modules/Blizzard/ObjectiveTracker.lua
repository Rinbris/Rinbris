local E, L, V, P, G = unpack(Rinbris)
local B = E:GetModule('Blizzard')

local select = select

local IsInInstance = IsInInstance
local ObjectiveTracker_Collapse = ObjectiveTracker_Collapse
local ObjectiveTracker_Expand = ObjectiveTracker_Expand
local C_QuestLog_IsComplete = C_QuestLog.IsComplete
local C_QuestLog_RemoveQuestWatch = C_QuestLog.RemoveQuestWatch

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

function B.QUEST_WATCH_UPDATE(_, _, questID)
    if C_QuestLog_IsComplete(questID) then
        C_QuestLog_RemoveQuestWatch(questID)
    end
end

function B:UpdateObjectiveTracker()
    ObjectiveTrackerFrame:SetScale(B.db.ObjectiveTrackerScale)

    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('QUEST_WATCH_UPDATE')
end