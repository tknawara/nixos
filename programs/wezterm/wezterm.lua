local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Mocha'
config.window_decorations = 'NONE'
config.font = wezterm.font 'CaskaydiaMono Nerd Font'
config.harfbuzz_features = { 'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09' }
config.enable_tab_bar = false
config.default_cursor_style = 'SteadyBlock'

return config
