local _, ns = ...
local M = ns:NewModule("Dialog")

-------------------------------------------------------------------------------

local GOSSIP_BUTTON_TYPE_OPTION, GOSSIP_BUTTON_TYPE_ACTIVE_QUEST, GOSSIP_BUTTON_TYPE_AVAILABLE_QUEST =
    GOSSIP_BUTTON_TYPE_OPTION, GOSSIP_BUTTON_TYPE_ACTIVE_QUEST, GOSSIP_BUTTON_TYPE_AVAILABLE_QUEST
local GossipFrame, QuestFrame, StaticPopup1, QuestFrameDetailPanel, QuestFrameProgressPanel, QuestFrameRewardPanel =
    GossipFrame, QuestFrame, StaticPopup1, QuestFrameDetailPanel, QuestFrameProgressPanel, QuestFrameRewardPanel
local QuestFrameCompleteButton, StaticPopup1Button1 = QuestFrameCompleteButton, StaticPopup1Button1
local QuestDetailAcceptButton_OnClick, QuestProgressCompleteButton_OnClick, QuestGoodbyeButton_OnClick, QuestRewardCompleteButton_OnClick =
    QuestDetailAcceptButton_OnClick, QuestProgressCompleteButton_OnClick, QuestGoodbyeButton_OnClick,
    QuestRewardCompleteButton_OnClick
local ENABLE_HOTKEYS_IN_COMBAT = true

-------------------------------------------------------------------------------

-- Thanks, [github]@mbattersby
-- Prefix list of GossipFrame(!!) options with 1., 2., 3. etc.
local function GossipDataProviderHook(frame)
  local dp = frame.GreetingPanel.ScrollBox:GetDataProvider()

  local n = 1
  for _, item in ipairs(dp.collection) do
    local tag
    if item.buttonType == GOSSIP_BUTTON_TYPE_OPTION then
      tag = "name"
    elseif item.buttonType == GOSSIP_BUTTON_TYPE_ACTIVE_QUEST or
        item.buttonType == GOSSIP_BUTTON_TYPE_AVAILABLE_QUEST then
      tag = "title"
    end

    if tag then
      local dedup = item.info[tag]:match("^%d+%. (.+)") or item.info[tag]
      item.info[tag] = n % 10 .. ". " .. dedup
      n = n + 1
    end

    if n > 10 then break end
  end

  frame.GreetingPanel.ScrollBox:SetDataProvider(dp)
end

function M:CreateHotkeyFrame()
  --- @class HotkeyFrame : Frame
  local HotkeyFrame = CreateFrame("Frame")

  HotkeyFrame:Hide()
  HotkeyFrame:SetFrameStrata("TOOLTIP")
  HotkeyFrame:SetFixedFrameStrata(true)

  HotkeyFrame.noPropagateFrame = CreateFrame("Frame", nil, HotkeyFrame)
  HotkeyFrame.noPropagateFrame:SetPropagateKeyboardInput(false)

  function HotkeyFrame:StopListeningKeys()
    self:SetScript("OnKeyDown", nil)
    self.noPropagateFrame:SetScript("OnKeyDown", nil)

    self:EnableKeyboard(false)
    self.noPropagateFrame:EnableKeyboard(false)
  end

  function HotkeyFrame:OnHide()
    self:StopListeningKeys()
  end

  function HotkeyFrame:OnKeyDown(key)
    local isConsumedHotkey = false

    if key == "G" then
      -- Accepting Quests
      if QuestFrameDetailPanel:IsVisible() then
        isConsumedHotkey = true
        QuestDetailAcceptButton_OnClick()
        -- Continue or Incomplete Quests
      elseif QuestFrameProgressPanel:IsVisible() then
        isConsumedHotkey = true
        if QuestFrameCompleteButton:IsEnabled() then
          QuestProgressCompleteButton_OnClick()
        else
          QuestGoodbyeButton_OnClick()
        end
        -- Completing Quests
      elseif QuestFrameRewardPanel:IsVisible() then
        isConsumedHotkey = true
        QuestRewardCompleteButton_OnClick()
        -- Popups
      elseif StaticPopup1:IsVisible() then
        isConsumedHotkey = true
        StaticPopup1Button1:Click()
      end
    end

    if GossipFrame.GreetingPanel:IsVisible() then
      local keynum = tonumber(key)

      if keynum and keynum >= 0 and keynum <= 9 then
        local button = M.gossips[keynum]

        if button then
          isConsumedHotkey = true
          button:Click()
        end
      end
    end

    if not InCombatLockdown() then
      HotkeyFrame:SetPropagateKeyboardInput(not isConsumedHotkey)
    elseif key == "ESCAPE" then
      -- In combat, allow the player to escape the dialog.
      HotkeyFrame.parent:Hide()
    end
  end

  function HotkeyFrame:SetParentFrame(frame)
    self.parent = frame;
    self:SetParent(frame);
    self:Show();

    self:StopListeningKeys();

    local listener

    if InCombatLockdown() then
      if ENABLE_HOTKEYS_IN_COMBAT then
        listener = self.noPropagateFrame
      end
    else
      listener = self
    end

    if listener then
      listener:SetScript("OnKeyDown", self.OnKeyDown)
      listener:EnableKeyboard(true)
    end
  end

  return HotkeyFrame
end

function M:OnGossipShow()
  local tabs = {}
  self.gossips = {}

  for _, v in pairs({ GossipFrame.GreetingPanel.ScrollBox.ScrollTarget:GetChildren() }) do
    tinsert(tabs, v)
  end

  for _, tab in ipairs(tabs) do
    if tab:GetObjectType() == "Button" and tab:IsVisible() then
      tinsert(self.gossips, tab)
    end
  end

  table.sort(self.gossips, function(a, b)
    if a.GetOrderIndex then
      return a:GetOrderIndex() < b:GetOrderIndex()
    else
      return a:GetTop() > b:GetTop()
    end
  end)
end

function M:OnLoad()
  self.HotkeyFrame = self:CreateHotkeyFrame()

  GossipFrame:HookScript("OnShow", function(frame)
    self.HotkeyFrame:SetParentFrame(frame)
  end)

  QuestFrame:HookScript("OnShow", function(frame)
    self.HotkeyFrame:SetParentFrame(frame)
  end)

  hooksecurefunc(GossipFrame, "Update", GossipDataProviderHook)

  StaticPopup1:HookScript("OnShow", function(frame)
    self.HotkeyFrame:SetParentFrame(frame)
  end)

  self:RegisterEvent("GOSSIP_SHOW", "OnGossipShow")
end
