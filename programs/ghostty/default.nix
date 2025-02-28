{ pkgs, inputs, config, ... }: {
  xdg.configFile."ghostty/config".text =
    # toml
    ''
      font-family = "${config.font.monospace.name}"
      font-size = 13
      font-feature = "calt, liga, ss02, ss03, ss04, ss05, ss06, ss07, ss08, ss09,ss19, ss20"
      gtk-titlebar = false
      theme = "catppuccin-mocha"
      window-padding-x = 6
      window-padding-y = 4
    '';
}
