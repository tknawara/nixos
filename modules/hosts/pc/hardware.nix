{ ... }: {
  flake.nixosModules.pcHardware = { config, lib, pkgs, ... }: {
    # Replaces: imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
    hardware.enableRedistributableFirmware = lib.mkDefault true;

    boot.initrd.availableKernelModules =
      [ "nvme" "xhci_pci" "ahci" "thunderbolt" "usbhid" "usb_storage" "uas" "sd_mod" ];
    # USB-C external drive requires these modules loaded early
    boot.initrd.kernelModules = [ "xhci_pci" "usb_storage" "uas" "sd_mod" ];
    boot.kernelModules = [ "kvm-amd" "nvidia_uvm" "nvidia_modeset" "nvidia_drm" ];
    boot.blacklistedKernelModules = [ "nouveau" ];
    boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4a0610d7-76fd-4276-a743-2460d84859f0";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/FDC2-25F2";
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
