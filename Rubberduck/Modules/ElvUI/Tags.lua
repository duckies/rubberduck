--- @type string, Addon
local _, ns = ...
--- @type ElvUI
local M = ns:GetModule("ElvUI")

local format = format
local UnitIsDead, UnitIsGhost, UnitIsConnected, UnitHealth, UnitHealthMax, IsResting = UnitIsDead, UnitIsGhost,
    UnitIsConnected, UnitHealth, UnitHealthMax, IsResting

function M:CreateTags()
  local E = self.ElvUI

  E:AddTag("duck:health:current-percent",
    "UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION PLAYER_FLAGS_CHANGED PLAYER_UPDATE_RESTING",
    function(unit)
      local status = UnitIsDead(unit) and "Dead"
          or UnitIsGhost(unit) and "Ghost"
          or not UnitIsConnected(unit) and "Offline"

      if status then
        return status
      end

      local health, healthMax = UnitHealth(unit), UnitHealthMax(unit)
      local healthPercent = health / healthMax * 100

      if (healthPercent ~= 100) then
        return format("%.1f%s | %s", healthPercent, "%", E:ShortValue(health))
      else
        return E:ShortValue(health)
      end
    end)

  E:AddTag("duck:resting", "PLAYER_UPDATE_RESTING", function(unit)
    if unit == 'player' and IsResting() then
      return "|cfff7d358zZz|r"
    end

    return nil
  end)
end
