{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [ "scala" "nix" ];
    userSettings = {
      features = { copilot = false; };
      vim_mode = true;
      load_direnv = "direct";
      buffer_font_size = 16;
      buffer_font_weight = 500;
      ui_font_size = 17;
      vim = {
        cursor_blink = false;
        toggle_relative_line_numbers = true;
      };
    };
  };
}
