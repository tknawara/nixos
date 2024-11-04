{ pkgs, config, ... }:

{
  programs.kitty = {
    enable = false;
    font = {
      package = config.font.monospace.package;
      name = "${config.font.monospace.name}";
    };

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
