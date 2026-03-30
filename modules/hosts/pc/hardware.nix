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

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/8b749ce6-4668-43ff-9f69-ea0781cca44c";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/89EF-33D3";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices =
      [{ device = "/dev/disk/by-uuid/e1360b18-0e31-499b-94be-f27cf8523870"; }];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
