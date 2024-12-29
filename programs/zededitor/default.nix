{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [ "scala" "nix" "java" "assembly" ];
    userSettings = {
      features = { copilot = false; };
      vim_mode = true;
      load_direnv = "direct";
      buffer_font_size = 15;
      buffer_font_weight = 500;
      buffer_font_family = "Cascadia Code NF";
      ui_font_size = 16;
      vim = {
        cursor_blink = false;
        toggle_relative_line_numbers = true;
      };
    };
  };
}
