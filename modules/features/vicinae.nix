{ self, inputs, ... }: {
  flake.nixosModules.vicinae = { pkgs, ... }: {
    imports = [ inputs.vicinae.nixosModules.default ];
    
    programs.vicinae = {
      enable = true;
      package = inputs.vicinae.packages.${pkgs.system}.default;
      # catppuccin.enable = true; # If available, but let's check settings
    };
  };

  # Package definition for niri binds if needed
  perSystem = { pkgs, ... }: {
    packages.vicinae = inputs.vicinae.packages.${pkgs.system}.default;
  };
}
