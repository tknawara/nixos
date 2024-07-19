{ pkgs, inputs, config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { family = "CaskaydiaMono Nerd Font"; };
        size = 11;
      };
      env = { TERM = "xterm-256color"; };
      window = {
        decorations = "full";
        dynamic_title = true;
        decorations_theme_variant = "Dark";
        # opacity = 0.9;
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
