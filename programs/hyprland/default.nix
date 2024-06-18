{ pkgs, lib, inputs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.dunst}/bin/dunst &

    sleep 1

    ${pkgs.swww}/bin/swww img ~/nixos/wallpapers/single-mountain-landscape.jpg
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
        "$mod, M, exit,"
        "$mod, V, togglefloating"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod_shift, left, movewindow, l"
        "$mod_shift, right, movewindow, r"
        "$mod_shift, up, movewindow, u"
        "$mod_shift, down, movewindow, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
}
