--- @type string, Addon
local _, ns = ...
--- @class ElvUI : Module
--- @field CreateTags fun(self: ElvUI)
local M = ns:NewModule("ElvUI")

-------------------------------------------------------------------------------

local ElvUI = ElvUI
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

-------------------------------------------------------------------------------

function M:OnElvUILoaded()
  self.ElvUI = { unpack(ElvUI) }
  self:CreateTags()
end

function M:OnLoad()
  if not IsAddOnLoaded("ElvUI") then return end;

  self.ElvUI = unpack(ElvUI)

  self:CreateTags();
end
