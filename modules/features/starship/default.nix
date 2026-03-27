{ ... }: {
  flake.hmModules.starship = { pkgs, ... }: {
    programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
  };
}
