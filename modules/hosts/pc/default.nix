{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.pcConfiguration
      inputs.home-manager.nixosModules.default
      inputs.catppuccin.nixosModules.catppuccin
    ];
  };

  flake.nixosModules.pcConfiguration = { pkgs, lib, ... }: {
    imports = [
      ./configuration.nix
      ./hardware.nix
      ./consts.nix
      self.nixosModules.niri
      self.nixosModules.shell
      self.nixosModules.essentials
      self.nixosModules.desktop
      self.nixosModules.vicinae
    ];
  };
}
