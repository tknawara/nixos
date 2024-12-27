{ pkgs, inputs, config, ... }: {
  xdg.configFile."ghostty/config".text =
    # toml
    ''
      font-family = "${config.font.monospace.name}"
      gtk-titlebar = false
      theme = "catppuccin-mocha"
      window-padding-x = 6
      window-padding-y = 4
    '';

  home.packages = [ inputs.ghostty.packages.${pkgs.system}.default ];
}
