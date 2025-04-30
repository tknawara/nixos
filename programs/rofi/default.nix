{ pkgs, inputs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,window,filebrowser";
      show-icons = true;
      icon-theme = "Papirus-Light";
      terminal = "ghostty";
      hide-scrollbar = true;
      sidebar-mode = true;
    };
  };
}
