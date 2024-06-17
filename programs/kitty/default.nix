{ pkgs, lib, inputs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";

    settings = {
      enable_audio_bell = false;
      background_opacity = "0.8";
      dynamic_background_opacity = true;
      open_url_with = "firefox";
      enable_layouts = "fat, tall, vertical";
      window_padding_width = 5;
      tab_bar_margin_width = 5;
      font_size = 11;
      font_family = "CaskaydiaMono Nerd Font";
    };
  };
}
