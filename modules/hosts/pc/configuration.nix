{ config, pkgs, inputs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Xanmod LTS kernel (desktop-optimized with LTS stability for Nvidia)
  boot.kernelPackages = pkgs.linuxPackages_xanmod;

  networking.hostName = "pc";
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable flakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 1024 * 1024 * 1024; # 1 GiB
    substituters = [ "https://vicinae.cachix.org" ];
    trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Unlock gnome-keyring on login
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Polkit agent (needed without GNOME for privilege escalation prompts)
  security.polkit.enable = true;

  # Minimal login
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri";
        user = "tarek";
      };
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Define a user account.
  users.users.tarek = {
    isNormalUser = true;
    description = "tarek";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish; # Switch to fish
  };

  # Docker
  virtualisation.docker.enable = true;

  # Printing
  services.printing.enable = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      cantarell-fonts
      cascadia-code
      config.font.monospace.package
      config.font.sansSerif.package
      config.font.serif.package
      monaspace
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      ubuntu_font_family
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "${config.font.monospace.name}" ];
        serif = [ "${config.font.serif.name}" ];
        sansSerif = [ "${config.font.sansSerif.name}" ];
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System wide programs
  programs.fish.enable = true;

  # Essential utilities
  environment.systemPackages = with pkgs; [
    # GPU
    config.boot.kernelPackages.nvidia_x11
    pciutils
    cudaPackages.cudatoolkit
    clinfo
    lact
    rocmPackages.amdsmi
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    # Login
    greetd.tuigreet
    # File management
    yazi
    xfce.thunar
    xfce.thunar-volman
    gvfs
    # Desktop utilities
    blueman
    networkmanagerapplet
    zathura
    imv
    wl-clipboard
    libnotify
  ];

  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.blueman.enable = true;
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    __GL_GSYNC_ALLOWED = "1";
    XDG_SESSION_TYPE = "wayland";
  };

  # Enable OpenCL
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ amdvlk rocmPackages.clr rocmPackages.clr.icd ];
  };

  # Load AMD + nvidia driver
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  system.stateVersion = "24.05";
}
