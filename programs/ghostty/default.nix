{ pkgs, inputs, config, ... }: {
  xdg.configFile."ghostty/config".text =
    # toml
    ''
      font-family = "${config.font.monospace.name}"
      font-size = 12
      gtk-titlebar = false
      theme = "catppuccin-mocha"
      window-padding-x = 6
      window-padding-y = 4
    '';
}
