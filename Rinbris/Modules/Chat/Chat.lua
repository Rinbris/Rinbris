local E = unpack(Rinbris)
local CH = E:GetModule('Chat')

-- WoW Globals
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS

local ChatHide = false

local textureMinimizeUp = [[Interface\CHATFRAME\UI-ChatIcon-Minimize-Up.blp]]
local textureMaximizeUp = [[Interface\CHATFRAME\UI-ChatIcon-Maximize-Up.blp]]

function CH:Alpha_OnEnter()
    if self:IsMouseOver() then
        self:SetAlpha(1)
    end 
end

function CH:Alpha_OnLeave()
    if not self:IsMouseOver() then
        self:SetAlpha(0)
    end
end

function CH:Toggle_OnMouseUp()
    if ChatHide  == false then
        self.t:SetTexture(textureMinimizeUp)
    elseif ChatHide == true then
        self.t:SetTexture(textureMaximizeUp)
    end
end

function CH:Toggle_OnMouseDown()
    if ChatHide == false then
        self.t:SetTexture([[Interface\CHATFRAME\UI-ChatIcon-Minimize-Down.blp]])
    elseif ChatHide == true then
        self.t:SetTexture([[Interface\CHATFRAME\UI-ChatIcon-Maximize-Down.blp]])
    end
end

function CH:HideChat_OnClick()
    if ChatHide == false then
        self.t:SetTexture(textureMaximizeUp)
        QuickJoinToastButton:Hide()
        GeneralDockManager:Hide()
        ChatFrame1.FontStringContainer:Hide()
        ChatFrameChannelButton:Hide()

        for i=1, NUM_CHAT_WINDOWS do
            _G['ChatFrame'..i..'']:SetAlpha(0)
            _G['ChatFrame'..i..'ButtonFrame']:Hide()
            _G['ChatFrame'..i..'EditBox']:Hide()
            _G['ChatFrame'..i..'']:Hide()
        end

        ChatHide = true
    elseif ChatHide == true then
        self.t:SetTexture(textureMinimizeUp)
        QuickJoinToastButton:Show()
        GeneralDockManager:Show()
        ChatFrame1:Show()
        ChatFrame1.FontStringContainer:Show()
        ChatFrameChannelButton:Show()

        for i=1, NUM_CHAT_WINDOWS do
            _G['ChatFrame'..i..'']:SetAlpha(1)
            _G['ChatFrame'..i..'ButtonFrame']:Show()
        end

        ChatHide = false
    end
end

function CH:BuildToggleButton()
    local Minimize = CreateFrame('Button', nil, UIParent)
    Minimize:SetSize(30,30)
    Minimize.t = Minimize:CreateTexture(nil, 'BORDER')
    Minimize.t:SetTexture(textureMinimizeUp)
    Minimize.t:SetAllPoints(Minimize)
    Minimize:SetPoint('BOTTOM', 'ChatFrame1ButtonFrame', 'BOTTOM', 0, -4)
    Minimize:Show()
    Minimize:SetAlpha(0)    
	Minimize:HookScript('OnEnter', self.Alpha_OnEnter)
	Minimize:HookScript('OnLeave', self.Alpha_OnLeave)
    Minimize:SetScript('onmousedown', self.Toggle_OnMouseUp)
    Minimize:SetScript('onmousedown', self.Toggle_OnMouseDown)
    Minimize:SetScript('onclick', self.HideChat_OnClick)
end

function CH:UpdatingChatFrame()
    ChatFrame1:ClearAllPoints()
    ChatFrame1:SetPoint('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 31, 0)

    for i = 1, 50 do
        local chatFrame = _G['ChatFrame' .. i]
        if chatFrame then
            local editBox = _G['ChatFrame' .. i .. 'EditBox']
            chatFrame:SetClampRectInsets(0, 0, 0, 0)
            editBox:ClearAllPoints()
            editBox:SetPoint('TOPLEFT', chatFrame, 0, 0)
            editBox:SetWidth(chatFrame:GetWidth())
            chatFrame:HookScript('OnSizeChanged', function()
                editBox:SetWidth(chatFrame:GetWidth())
            end)
        end
    end

    ChatFrameMenuButton:Hide()

    hooksecurefunc('FloatingChatFrame_UpdateBackgroundAnchors', function(self)
        self:SetClampRectInsets(0, 0, 0, 0)
    end)

    hooksecurefunc('FCF_OpenTemporaryWindow', function()
        local cf = FCF_GetCurrentChatFrame():GetName() or nil
        if cf then
            _G[cf]:SetClampRectInsets(0, 0, 0, 0)
            _G[cf .. 'EditBox']:ClearAllPoints()
            _G[cf .. 'EditBox']:SetPoint('TOPLEFT', cf, 'TOPLEFT', 0, 0)
            _G[cf .. 'EditBox']:SetWidth(_G[cf]:GetWidth())
            _G[cf]:HookScript('OnSizeChanged', function()
                    _G[cf .. 'EditBox']:SetWidth(_G[cf]:GetWidth())
            end)
        end
    end)
end

function CH:Initialize()
    if not E.private.chat.enable then
        return
    end

    self.db = E.db.chat

    DEFAULT_CHATFRAME_ALPHA = 0

    self:UpdatingChatFrame()
    self:BuildToggleButton()

    self.Initialized = true
end

E:RegisterModule(CH:GetName())
