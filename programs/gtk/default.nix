{ pkgs, ... }:

{
  gtk = {
    font = {
      package = pkgs.inter;
      name = "Inter";
      size = 10;
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adt-gtk3";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.gnome-keyring.enable = true;
}
