{ self, inputs, ... }: {
  flake.nixosModules.essentials = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      yazi
      xfce.thunar
      xfce.thunar-volman
      gvfs
      blueman
      networkmanagerapplet
      zathura
      imv
      wl-clipboard
      libnotify
      swww # Wallpaper
      kitty # Terminal
      wezterm
    ];

    services.gvfs.enable = true; # Needed for thunar
    services.udisks2.enable = true; # Needed for thunar
  };
}
