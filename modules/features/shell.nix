{ self, inputs, ... }: {
  flake.nixosModules.shell = { pkgs, ... }: {
    programs.fish = {
      enable = true;
      # catppuccin.enable = true; # If using the nixos module
    };

    # Catppuccin for fish can be enabled via home-manager or nixos module
    # Since we have the nixos module for catppuccin in host/pc/default.nix, we can use it here
    catppuccin.fish.enable = true;

    environment.systemPackages = with pkgs; [
      any-nix-shell
      starship
    ];

    programs.starship = {
      enable = true;
      catppuccin.enable = true;
    };
  };

  # Nushell module but not imported by default
  flake.nixosModules.nushell = { pkgs, ... }: {
    programs.nushell = {
      enable = true;
      # existing nushell config from programs/nushell/...
    };
  };
}
