{ pkgs, configs, ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 10000;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [ catppuccin ];
    extraConfig = ''
      set -g mouse on
    '';
  };
}
