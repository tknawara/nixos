{ ... }: {
  flake.hmModules.zoxide = { pkgs, ... }: {
    programs.zoxide = {
    enable = false;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
  };
}
