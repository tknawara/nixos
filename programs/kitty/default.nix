{ pkgs, lib, inputs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";

    settings = {
      enable_audio_bell = false;
      dynamic_background_opacity = true;
      open_url_with = "firefox";
      enable_layouts = "fat, tall, vertical";
      window_padding_width = 5;
      background_opacity = "0.8";
      tab_bar_margin_width = 5;
    };
  };
}
