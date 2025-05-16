local wezterm = require("wezterm")
local config = wezterm.config_builder()
local is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

config.initial_cols = 150
config.initial_rows = 60

config.font = wezterm.font("MesloLGL Nerd Font Mono")
config.font_size = is_darwin() and 14 or 10
config.color_scheme = 'Catppuccin Mocha'
config.colors = {
  background = "black"
}

config.enable_tab_bar = false
config.window_background_opacity = 0.8

config.default_prog = { os.getenv("HOME") .. "/.local/bin/tmux-either.sh" }

return config
