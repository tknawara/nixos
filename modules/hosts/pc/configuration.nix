{ config, pkgs, inputs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.tarek = {
      imports = [ ../../../home.nix inputs.catppuccin.homeModules.catppuccin ];
    };
  };

  # System wide programs
  programs = {
    fish.enable = true;
    niri.enable = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    linuxPackages.nvidia_x11
    pciutils
    cudaPackages.cudatoolkit
    clinfo
    lact
    rocmPackages.amdsmi
    rocmPackages.rocm-smi
    rocmPackages.rocminfo
    greetd.tuigreet
  ];
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
