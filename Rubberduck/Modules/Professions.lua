--- @type string, Addon
local _, ns = ...

local GetProfessions, GetSpellInfo, GetProfessionInfo = GetProfessions, GetSpellInfo, GetProfessionInfo;
local CreateFrame = CreateFrame;

-------------------------------------------------------------------------------

--- @class ProfessionsModule : Module
local M = ns:NewModule("Professions");

local tabList = {};

-------------------------------------------------------------------------------

function M:CreateSpellTab(spellID)
  local name, _rank, texture = GetSpellInfo(spellID)

  DevTool:AddData({ spellID, name, texture });

  local tab = CreateFrame("CheckButton", nil, _G.ProfessionsFrame,
    "SpellBookSkillLineTabTemplate, SecureActionButtonTemplate");
  tab.tooltip = name;
  tab.spellID = spellID;
  tab.type = "spell";


  -- if not name then return end;

  tab:RegisterForClicks("AnyDown");
  tab:SetAttribute("type", tab.type);
  tab:SetAttribute(tab.type, spellID or name);
  tab:SetNormalTexture(texture);
  -- tab:GetHighlightTexture():SetColorTexture(...)
  tab:Show();

  tab.CD = CreateFrame("Cooldown", nil, tab, "CooldownFrameTemplate");
  tab.CD:SetAllPoints();

  tab.cover = CreateFrame("Frame", nil, tab);
  tab.cover:SetAllPoints();
  tab.cover:EnableMouse(true);

  tab:SetPoint("TOPLEFT", _G.ProfessionsFrame, "TOPRIGHT", 3, -self.tabs * 42);
  tinsert(tabList, tab);

  self.tabs = self.tabs + 1;
end

function M:UpdateTabs()
  for _, tab in pairs(tabList) do
    local spellID = tab.spellID;
    local itemID = tab.itemID;

    if IsCurrentSpell(spellID) then
      tab:SetChecked(true)
      tab.cover:Show()
    else
      tab:SetChecked(false)
      tab.cover:Hide()
    end

    local start, duration
    if itemID then
      start, duration = GetItemCooldown(itemID)
    else
      start, duration = GetSpellCooldown(spellID)
    end
    if start and duration and duration > 1.5 then
      tab.CD:SetCooldown(start, duration)
    end
  end
end

function M:LoadProfessionTabs()
  self.tabs = 1;
  -- TODO: Combat check.
  local professionIndices = { GetProfessions() };

  for _, professionIndex in pairs(professionIndices) do
    local name, _, _, _, numSpells, spelloffset, skillLine = GetProfessionInfo(professionIndex);
    local slotID = 1 + spelloffset;

    if not IsPassiveSpell(slotID, BOOKTYPE_PROFESSION) then
      local spellID = select(2, GetSpellBookItemInfo(slotID, BOOKTYPE_PROFESSION));

      self:CreateSpellTab(spellID);
    end
  end

  DevTool:AddData(self.tabList);
end

function M:OnLoad()
  self:RegisterEvent("PLAYER_STARTED_MOVING", function(self)
    _G.ProfessionsFrame:HookScript("OnShow", function()
      M:LoadProfessionTabs();
    end);

    M:RegisterEvent("TRADE_SKILL_SHOW", M.UpdateTabs);
    M:RegisterEvent("TRADE_SKILL_CLOSE", M.UpdateTabs);
    M:RegisterEvent("CURRENT_SPELL_CAST_CHANGED", M.UpdateTabs);

    M:UnregisterEvent("PLAYER_STARTED_MOVING");
  end)
end
