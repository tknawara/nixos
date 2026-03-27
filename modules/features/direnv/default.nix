{ ... }: {
  flake.hmModules.direnv = { pkgs, ... }:

    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
