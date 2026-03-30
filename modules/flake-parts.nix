{ inputs, ... }: {
  options.flake = inputs.flake-parts.lib.mkSubmoduleOptions {
    hmModules = inputs.nixpkgs.lib.mkOption {
      default = {};
    };
  };

  config.systems = [ "x86_64-linux" ];

  # Apply overlay to make noctalia-shell available in perSystem pkgs
  config.perSystem = { system, ... }: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          noctalia-shell = inputs.noctalia-shell.packages.${system}.default;
        })
      ];
    };
  };
}
