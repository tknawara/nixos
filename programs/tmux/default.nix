{ pkgs, configs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    clock24 = true;
    historyLimit = 10000;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [ catppuccin ];
    extraConfig = ''
      set -g mouse on
    '';
  };
}
