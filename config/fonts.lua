local wezterm = require('wezterm')
local platform = require('utils.platform')

local font_family = os.getenv('WEZTERM_FONT_FAMILY')
   or (platform.is_linux and 'FiraCode Nerd Font Mono' or 'JetBrainsMono Nerd Font')
local font_weight = platform.is_linux and 'Regular' or 'Medium'

local font_size = platform.is_mac and 12 or 9.75

return {
   font = wezterm.font({
      family = font_family,
      weight = font_weight,
   }),
   font_size = font_size,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
