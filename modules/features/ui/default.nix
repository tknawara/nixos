{ ... }: {
  flake.hmModules.ui = { pkgs, lib, config, ... }: {
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
    pinentry.package = pkgs.pinentry-qt;
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
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    xdgOpenUsePortal = true;
  };

  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.ScreenCast=gnome
    org.freedesktop.impl.portal.Screenshot=gnome
  '';
  };
}
