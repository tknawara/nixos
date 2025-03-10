{ pkgs, config, inputs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store &                  
    ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store &
    hyprctl setcursor 'breeze_cursorts' 25

    sleep 1
    ${pkgs.swww}/bin/swww img ${config.wallpaper}
  '';
in {

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = "${startupScript}/bin/start";

      group = {
        groupbar = {
          font_family = "Cascadia Code NF";
          font_size = 12;
          text_color = "rgba($subtext1Alphaee)";
          render_titles = false;
          "col.active" = "rgba($greenAlphaee)";
          "col.inactive" = "rgba($baseAlphaee)";
        };
      };

      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, wezterm"

        "$mod, SPACE, exec, rofi -show drun"
        "$mod SHIFT, SPACE, exec, rofi -show window"

        "$mod, Q, killactive"
        "$mod, M, exit,"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"

        "$mod, t, togglegroup"

        "$mod, l, movefocus, l"
        "$mod, h, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        "$mod SHIFT, Q, exec, hyprlock"

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

        "$mod, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, S, exec, hyprshot --mode region --clipboard-only"

        "$mod SHIFT, S, exec, hyprshot -m output -o ~/Pictures/Screenshots"
        "$mod SHIFT, W, exec, hyprshot -m window -o ~/Pictures/Screenshots"
      ];
    };
    extraConfig = # conf
      ''
        monitor=,preferred,auto,1.2
        xwayland {
          force_zero_scaling = true
        }

        # windowrulev2 = fullscreen, workspace:3

        bind = $mod, R, submap, resize
        submap = resize
        binde = , l, resizeactive, 10 0
        binde = , h, resizeactive, -10 0
        binde = , k, resizeactive, 0 -10
        binde = , j, resizeactive, 0 10
        bind = , escape, submap, reset
        submap = reset

        bind = $mod, G, submap, grouping 
        submap = grouping 
        bind = SHIFT, h, moveintogroup, l 
        bind = SHIFT, l, moveintogroup, r 
        bind = SHIFT, k, moveintogroup, u 
        bind = SHIFT, j, moveintogroup, d 
        bind = , h, changegroupactive, b 
        bind = , l, changegroupactive, f 
        bind = , escape, submap, reset
        submap = reset
      '';
  };
}
