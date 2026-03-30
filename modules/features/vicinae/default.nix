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
      systemd.enable = true;
    };

    systemd.user.services.vicinae.Service.Environment = [
      "QT_QPA_PLATFORM=wayland"
      "WAYLAND_DISPLAY=wayland-1"
    ];
  };

  # Package definition for niri binds if needed
  perSystem = { pkgs, ... }: {
    packages.vicinae = vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
