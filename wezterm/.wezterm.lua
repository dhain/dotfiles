local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGL Nerd Font Mono")
config.font_size = 14
config.color_scheme = 'Catppuccin Mocha'

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8

return config
