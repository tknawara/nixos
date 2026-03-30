{ ... }: {
  flake.nixosModules.pcHardware = { config, lib, pkgs, ... }: {
    # Replaces: imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    boot.initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" "nvidia_uvm" "nvidia_modeset" "nvidia_drm" ];
    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.extraModulePackages = [ ];



  fileSystems."/" =
    { device = "/dev/disk/by-uuid/19ec9b96-4c3a-4fd7-818c-2b284c184461";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/036C-70BE";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };


  swapDevices = [ ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
