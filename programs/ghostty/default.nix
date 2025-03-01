{ pkgs, inputs, config, ... }: {
  xdg.configFile."ghostty/config".text =
    # toml
    ''
      theme = "catppuccin-mocha"

      font-family = "${config.font.monospace.name}"
      font-size = 12
      font-feature = "calt"
      font-feature = "liga"
      font-feature = "ss02"
      font-feature = "ss03"
      font-feature = "ss04"
      font-feature = "ss04"
      font-feature = "ss05"
      font-feature = "ss06"
      font-feature = "ss07"
      font-feature = "ss08"
      font-feature = "ss09"
      font-feature = "ss19"
      font-feature = "ss20"

      gtk-titlebar = false
      window-padding-x = 6
      window-padding-y = 4
    '';
}
