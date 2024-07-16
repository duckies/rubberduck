--- @type string, Addon
local addonName, ns = ...

-------------------------------------------------------------------------------

--- @class EventMixin
--- @field public RegisterEvent fun(self:EventMixin, event:WowEvent, method?: function | string | nil)
local EventMixin = {}

local frame = CreateFrame("Frame", addonName .. "EventFrame")

local metatable = {
  __index = function(t, k)
    t[k] = {}
    return t[k]
  end
}

--- @type table<string, table<table, function>>
local events = setmetatable({}, metatable)
--- @type table<string, table<table, function>>
-- local queue = setmetatable({}, metatable)

--- @class Registry
--- @field queue table<string, table<Module, function>> | nil
local registry = { depth = 0, events = events, }

-------------------------------------------------------------------------------

--- @param target table
--- @param method function | string
local function CreateCallback(target, method)
  if type(method) == "string" then
    if type(target[method]) ~= "function" then
      error(("Unable to create callback: %s is not a function"):format(method))
    end

    return function(...)
      target[method](target, ...)
    end
  end

  return method
end

--- @param event WowEvent
--- @param method function | string | nil
function EventMixin:RegisterEvent(event, method)
  local callback = CreateCallback(self, method or event)

  local isNew = not rawget(events, event) or not next(events[event])

  if events[event][self] or registry.depth < 1 then
    -- Overwriting an existing callback, or registering a new callback while not in a callback.
    events[event][self] = callback

    if isNew then
      frame:RegisterEvent(event)
    end
  else
    -- Registering a new callback while inside a callback.
    registry.queue = registry.queue or setmetatable({}, metatable);
    registry.queue[event][self] = callback
  end
end

--- @param event WowEvent
function EventMixin:UnregisterEvent(event)
  if rawget(events, event) and events[event][self] then
    events[event][self] = nil

    if not next(events[event]) then
      frame:UnregisterEvent(event)
    end
  end

  if registry.queue and rawget(registry.queue, event) and registry.queue[event][self] then
    registry.queue[event][self] = nil
  end
end

--- @param name string Addon name.
--- @param method function | string
function EventMixin:OnAddonLoaded(name, method)
  local callback = CreateCallback(self, method)

  if C_AddOns.IsAddOnLoaded(name) then
    callback(self)
    return
  end

  self:RegisterEvent("ADDON_LOADED", function(self, loadedName)
    if loadedName == name then
      self:UnregisterEvent("ADDON_LOADED")
      callback(self)
    end
  end)
end

-------------------------------------------------------------------------------

--- @param callbacks table<table, function>
local function Dispatch(callbacks, ...)
  local index, callback = next(callbacks)
  if not callback then return end
  repeat
    securecallfunction(callback, ...)
    index, callback = next(callbacks, index)
  until not callback
end

local function EmitEvent(event, ...)
  if not rawget(events, event) or not next(events[event]) then return end

  local startDepth = registry.depth
  registry.depth = startDepth + 1

  Dispatch(events[event], event, ...)

  registry.depth = startDepth

  if registry.queue and startDepth == 0 then
    for event, callbacks in pairs(registry.queue) do
      local isNew = not rawget(events, event) or not next(events[event])

      for target, callback in pairs(callbacks) do
        events[event][target] = callback

        if isNew then
          frame:RegisterEvent(event)
          isNew = false;
        end
      end
    end
    registry.queue = nil;
  end
end

-------------------------------------------------------------------------------

frame:SetScript("OnEvent", function(_frame, event, ...)
  EmitEvent(event, ...)
end)

ns.mixins.EventMixin = EventMixin
