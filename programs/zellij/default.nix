{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      pane_frames = false;
    };
  };
}
