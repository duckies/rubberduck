--- @type string, Addon
local _, ns = ...
local M = ns:NewModule("MoveFrames")

-------------------------------------------------------------------------------

local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
local BlizzMoveAPI = _G.BlizzMoveAPI

-------------------------------------------------------------------------------

function M:OnLoad()
  if not IsAddOnLoaded("BlizzMove") then return end

  BlizzMoveAPI:RegisterAddOnFrames({
    ["ElvUI"] = {
      ["ElvUIPetBattleActionBar"] = {
        MinVersion = 0
      }
    }
  })
end
