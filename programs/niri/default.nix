{ inputs, config, pkgs, lib, ... }:
let makeCommand = command: { command = [ command ]; };
in {
  imports = [ inputs.niri.homeModules.niri ];
  programs.fuzzel = { enable = true; };
  programs.niri = {
    enable = true;

    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };

      spawn-at-startup = [
        (makeCommand
          "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store")
        (makeCommand
          "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store")
        (makeCommand "${pkgs.waybar}/bin/waybar")
        (makeCommand "${pkgs.xwayland-satellite}/bin/xwayland-satellite")
        (makeCommand "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper}")
      ];

      outputs = {
        "DP-2" = {
          scale = 1.2;
          position = {
            x = 0;
            y = 0;
          };
        };
      };

      hotkey-overlay.skip-at-startup = false;

      layout = {
        focus-ring = {
          enable = true;
          width = 0.1;
        };
        border = { enable = false; };
        default-column-width = { proportion = 0.5; };
      };

      prefer-no-csd = true;
      input = { focus-follows-mouse.enable = true; };

      binds = with config.lib.niri.actions;
        let sh = spawn "sh" "-c";
        in {
          "Mod+Shift+E".action = quit;
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          # Applications
          "Mod+Space".action = sh "rofi -show drun -show-icon";
          "Mod+C".action =
            sh "cliphist list | rofi -dmenu | cliphist decode | wl-copy";
          "Mod+Return".action = spawn "wezterm";
          "Ctrl+Alt+L".action = spawn "hyprlock";

          # Window management
          "Mod+Q".action = close-window;
          "Mod+S".action = switch-preset-column-width;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+V".action = toggle-window-floating;

          # Focus movement
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;
          "Mod+J".action = focus-window-or-workspace-down;
          "Mod+K".action = focus-window-or-workspace-up;
          "Mod+Left".action = focus-column-left;
          "Mod+Right".action = focus-column-right;
          "Mod+Down".action = focus-workspace-down;
          "Mod+Up".action = focus-workspace-up;

          # Window movement
          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+L".action = move-column-right;
          "Mod+Shift+K".action = move-column-to-workspace-up;
          "Mod+Shift+J".action = move-column-to-workspace-down;
          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;

          # Workspaces
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
        };
    };
  };

  systemd.user = {
    services = {
      xwayland-satellite = {
        Install = { WantedBy = [ "niri.service" ]; };
        Unit = {
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          Requisite = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${lib.getExe pkgs.xwayland-satellite}";
          Restart = "on-failure";
        };
      };

      swww-daemon = {
        Install = { WantedBy = [ "niri.service" ]; };
        Unit = {
          Description = "swww-daemon";
          After = [ "graphical-session.target" ];
          PartOf = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${pkgs.swww}/bin/swww-daemon";
          ExecStop = "${pkgs.swww}/bin/swww kill";
          Restart = "always";
          RestartSec = 10;
        };
      };
    };
  };
}
