---@type Wezterm
local wezterm = require('wezterm')

local M = {}

local function normalize_decorations(decorations)
   return (decorations or 'TITLE|RESIZE'):gsub('%s+', '')
end

local function has_flag(decorations, flag)
   return decorations:find(flag, 1, true) ~= nil
end

M.setup = function()
   wezterm.on('window.toggle-title-bar', function(window, _pane)
      local overrides = window:get_config_overrides() or {}
      local current =
         overrides.window_decorations
         or window:effective_config().window_decorations
         or 'TITLE|RESIZE'

      current = normalize_decorations(current)

      if has_flag(current, 'TITLE') or has_flag(current, 'INTEGRATED_BUTTONS') then
         local next_decorations = {}

         if has_flag(current, 'RESIZE') then
            table.insert(next_decorations, 'RESIZE')
         end

         if has_flag(current, 'MACOS_FORCE_ENABLE_SHADOW') then
            table.insert(next_decorations, 'MACOS_FORCE_ENABLE_SHADOW')
         end

         overrides.window_decorations = #next_decorations > 0
               and table.concat(next_decorations, '|')
            or 'NONE'
      else
         local next_decorations = { 'TITLE', 'RESIZE' }

         if has_flag(current, 'MACOS_FORCE_ENABLE_SHADOW') then
            table.insert(next_decorations, 'MACOS_FORCE_ENABLE_SHADOW')
         end

         overrides.window_decorations = table.concat(next_decorations, '|')
      end

      window:set_config_overrides(overrides)
   end)
end

return M
