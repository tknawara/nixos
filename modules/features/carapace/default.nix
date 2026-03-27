{ ... }: {
  flake.hmModules.carapace = { pkgs, ... }:

    {
      programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
    };
}
