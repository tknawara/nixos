{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = { pane_frames = false; };
  };
}
