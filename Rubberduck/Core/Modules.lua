--- @type string, Addon
local addonName, ns = ...

local Mixin = Mixin

-------------------------------------------------------------------------------

--- @class ModuleMixin: Module
local ModuleMixin = {}

-------------------------------------------------------------------------------

function ModuleMixin:GetName()
  return self.name
end

function ModuleMixin:IsEnabled()
  return self.enabled
end

function ns:NewModule(name, base)
  --- @class Module
  local module = base and base or {}
  module.name = name
  module.enabled = false

  if not self.modules then
    self.modules = {}
  elseif self.modules[name] then
    error(("Module %s already exists."):format(name), 2)
  end

  Mixin(module, self.mixins.EventMixin, ModuleMixin)

  setmetatable(module, {
    __tostring = function(t) return format('<Module "%s">', t:GetName()) end,
    --- @param table Module
    --- @param key string
    --- @param value function
    __newindex = function(table, key, value)
      if key == "OnLoad" then
        if type(value) ~= "function" then
          error(("%s:OnLoad must be a function."):format(module:GetName()))
        end
        table:RegisterEvent("ADDON_LOADED", function(_self, name)
          if name == addonName then
            value(table)
            table:UnregisterEvent("ADDON_LOADED")
          end
        end)
      else
        rawset(table, key, value)
      end
    end,
  })

  self.modules[name] = module

  return module
end

function ns:GetModule(name)
  if not self.modules or not self.modules[name] then
    error(("Module %s does not exist."):format(name), 2)
  end

  return self.modules[name]
end

-------------------------------------------------------------------------------

ns.mixins.ModuleMixin = ModuleMixin
