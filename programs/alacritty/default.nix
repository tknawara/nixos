{ pkgs, inputs, config, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = { family = "CaskaydiaMono Nerd Font"; };
        size = 11;
      };
      window = {
        decorations = "full";
        opacity = 0.85;
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
}
