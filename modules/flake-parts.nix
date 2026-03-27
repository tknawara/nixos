{ inputs, ... }: {
  options.flake = inputs.flake-parts.lib.mkSubmoduleOptions {
    hmModules = inputs.nixpkgs.lib.mkOption {
      default = {};
    };
  };

  config.systems = [ "x86_64-linux" ];
}
