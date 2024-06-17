{ pkgs, lib, inputs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

    ${pkgs.swww}/bin/swww img ${
      ../../wallpapers/beautiful-mountains-landscape.jpg
    } &
  '';
in {

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = "${startupScript}/bin/start";

      "$mod" = "SUPER";
      "$mod_shfit" = "SUPER SHIFT";
      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod_shift, SPACE, exec, rofi -show window"
        "$mod, Q, killactive"
      ];
    };
  };
}
