{ pkgs, inputs, ... }: {
  programs.rofi = {
    enable = true;
    theme =
      "${inputs.catppuccin-rofi}/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,window,filebrowser";
      show-icons = true;
      icon-theme = "Papirus-Light";
      terminal = "kitty";
      hide-scrollbar = true;
      sidebar-mode = true;
    };
  };
}
