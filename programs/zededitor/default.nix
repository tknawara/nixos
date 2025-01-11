{ pkgs, ... }:

{
  catppuccin.zed.enable = false;
  programs.zed-editor = {
    enable = true;
    extensions =
      [ "catppuccin" "scala" "nix" "java" "assembly" "log" "fsharp" "csharp" ];
    userSettings = {
      features = { copilot = false; };
      vim_mode = true;
      load_direnv = "direct";
      buffer_font_size = 16;
      theme = {
        dark = "Catppuccin Mocha";
        light = "Catppuccin Mocha";
      };
      ui_font_size = 16;
      buffer_font_family = "Cascadia Code NF";
      vim = {
        cursor_blink = false;
        toggle_relative_line_numbers = true;
      };
    };
  };
}
