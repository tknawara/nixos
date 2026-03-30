{ ... }: {
  flake.hmModules.neovide = { pkgs, ... }: {
  xdg.configFile."neovide" = {
    source = ./dotfiles;
    recursive = true;
  };
}; }
