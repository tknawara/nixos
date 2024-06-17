{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    theme = ./catppuccin.rasi;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,window,filebrowser";
      show-icons = true;
      icon-theme = "Papirus-Light";
    };
  };
}
