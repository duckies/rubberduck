local _, ns = ...
local M = ns:NewModule("Currency")

-------------------------------------------------------------------------------

local GameTooltip, C_CurrencyInfo, Enum = GameTooltip, C_CurrencyInfo, Enum
local TooltipDataProcessor = TooltipDataProcessor

-------------------------------------------------------------------------------

M.total = "?/?"

function M:Update()
  local data = C_CurrencyInfo.GetCurrencyInfo(3010)

  if data then
    self.total = string.format("%d/%d", data.totalEarned, data.maxQuantity)
  end
end

function M:OnLoad()
  self:RegisterEvent("CURRENCY_DISPLAY_UPDATE", "Update")

  if not self.initialized then
    self.initialized = true
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
      if tooltip ~= GameTooltip then return end

      local _, _, id = tooltip:GetItem()

      if id ~= 213089 then return end

      tooltip:AddDoubleLine("Season Total", self.total, nil, nil, 1, 1, 1)
    end)
    self:Update()
  end
end
