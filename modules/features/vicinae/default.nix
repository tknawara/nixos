{ self, inputs, ... }:
let
  vicinae = inputs.vicinae;
in {
  # Vicinae is a Home Manager module
  flake.hmModules.vicinae = { pkgs, ... }: {
    imports = [ vicinae.homeManagerModules.default ];

    services.vicinae = {
      enable = true;
      package = vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;
      systemd.enable = false;
    };
  };

  # Package definition for niri binds if needed
  perSystem = { pkgs, ... }: {
    packages.vicinae = vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
