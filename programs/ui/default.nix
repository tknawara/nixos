{ pkgs, lib, config, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = "Ubuntu";
      size = 10;
      package = pkgs.ubuntu_font_family;
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    cursorTheme = {
      package = pkgs.kdePackages.breeze;
      name = "Breeze_Dark";
      size = 25;
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.gnome-keyring.enable = true;

  home = {
    pointerCursor.package = pkgs.kdePackages.breeze;
    pointerCursor.name = "breeze_cursors";
    pointerCursor.gtk.enable = true;
    pointerCursor.x11.enable = true;
    pointerCursor.size = 25;
    sessionVariables.XCURSOR_THEME = "Breeze_Dark";
  };

  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland
  '';

  xdg.portal = {
    enable = true;
    config = {
      common = { default = [ "hyprland" ]; };
      hyprland = { default = [ "gtk" "hyprland" ]; };
    };
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    xdgOpenUsePortal = true;
  };
}
