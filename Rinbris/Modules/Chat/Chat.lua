local E, L, V, P, G = unpack(Rinbris)
local C = E:GetModule('Chat')

local ChatHide = false

function C:Toggle_OnEnter()
    if self:IsMouseOver() then self:SetAlpha(1) end 
end

function C:Toggle_OnLeave()
    if not self:IsMouseOver() then self:SetAlpha(0) end
end

function C:Toggle_OnMouseUp()
    if ChatHide  == false then
        self.t:SetTexture('Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp')
    elseif ChatHide == true then
        self.t:SetTexture('Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp')
    end
end

function C:Toggle_OnMouseDown()
    if ChatHide == false then
        self.t:SetTexture('Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Down.blp')
    elseif ChatHide == true then
        self.t:SetTexture('Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Down.blp')
    end
end

function C:Toggle_OnClick()
    if ChatHide == false then
        self.t:SetTexture('Interface\\CHATFRAME\\UI-ChatIcon-Maximize-Up.blp')
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
        self.t:SetTexture('Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp')
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

function C:BuildToggleButton()
    local Minimize = CreateFrame('Button', nil, UIParent)
    Minimize:SetSize(30,30)
    Minimize.t = Minimize:CreateTexture(nil, 'BORDER')
    Minimize.t:SetTexture('Interface\\CHATFRAME\\UI-ChatIcon-Minimize-Up.blp')
    Minimize.t:SetAllPoints(Minimize)
    Minimize:SetPoint('BOTTOM', 'ChatFrame1ButtonFrame', 'BOTTOM', 0, -4)
    Minimize:Show()
    Minimize:SetAlpha(0)    
	Minimize:HookScript('OnEnter', C.Toggle_OnEnter)
	Minimize:HookScript('OnLeave', C.Toggle_OnLeave)
    Minimize:SetScript('onmousedown', C.Toggle_OnMouseUp)
    Minimize:SetScript('onmousedown', C.Toggle_OnMouseDown)
    Minimize:SetScript('onclick', C.Toggle_OnClick)
end

function C:Initialize()
    if not E.private.chat.enable then return end

    self.Initialized = true

    C.db = E.db.chat

    DEFAULT_CHATFRAME_ALPHA = 0

    ChatFrameMenuButton:Hide()

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

    C:BuildToggleButton()
end

E:RegisterModule(C:GetName())
