--- @meta

--- @class Module: EventMixin
--- @field protected name string
--- @field protected enabled boolean
--- @field public GetName fun(self:Module): string
--- @field public IsEnabled fun(self:Module): boolean
--- @field public OnLoad? fun(self:Module)

--- @class Addon: Module
--- @field NewModule fun(self: Addon, name: string, base?: table): Module
--- @field GetModule fun(self: Addon, name: string): Module
--- @field mixins table<string, table>
--- @field modules table<string, Module>
