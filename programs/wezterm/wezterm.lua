local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Macchiato'
config.window_decorations = 'NONE'
config.font = wezterm.font 'CaskaydiaMono Nerd Font'
config.harfbuzz_features = { 'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09' }
config.enable_wayland = false
config.enable_tab_bar = false
config.window_background_opacity = 0.8
config.default_cursor_style = 'SteadyBlock'

return config
