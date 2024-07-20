{ pkgs, lib, inputs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = false;
      dynamic_background_opacity = true;
      open_url_with = "firefox";
      enable_layouts = "fat, tall, vertical";
      window_padding_width = 5;
      tab_bar_margin_width = 5;
    };
  };
}
