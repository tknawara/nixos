{ self, inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
        v2-settings = true;
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

          outputs."DP-1" = {
            scale = 1.5;
            mode = "3840x2160@120";
          };

          prefer-no-csd = _: {};

          spawn-at-startup = [
            [ "sh" "-c" "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" ]
            [ (lib.getExe pkgs.noctalia-shell) ]
            [ (lib.getExe pkgs.xwayland-satellite) ]
            [
              "${pkgs.clipse}/bin/clipse"
              "-listen"
            ]
            [ (lib.getExe self'.packages.vicinae) "server" ]
            # [ "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1" ]
          ];

          input = {
            keyboard.xkb.layout = "us";
            focus-follows-mouse = _: {};
          };

          layout = {
            gaps = 5;
            focus-ring.width = 2;
            default-column-width.proportion = 0.5;
          };

          window-rules = [
            {
              matches = [ { app-id = "^clipse$"; } ];
              open-floating = true;
            }
          ];

          binds = {
            "Mod+Return".spawn = "wezterm";
            "Mod+Q".close-window = _: {};
            "Mod+Space".spawn = [
              (lib.getExe self'.packages.vicinae)
              "toggle"
            ];
            "Mod+C".spawn = [
              "wezterm"
              "start"
              "--class"
              "clipse"
              "-e"
              "clipse"
            ];

            "Mod+Shift+E".quit = _: {};
            "Mod+Shift+Slash".show-hotkey-overlay = _: {};

            # Window management
            "Mod+S".switch-preset-column-width = _: {};
            "Mod+F".maximize-column = _: {};
            "Mod+Shift+F".fullscreen-window = _: {};
            "Mod+V".toggle-window-floating = _: {};

            # Focus movement
            "Mod+H".focus-column-left = _: {};
            "Mod+L".focus-column-right = _: {};
            "Mod+J".focus-window-or-workspace-down = _: {};
            "Mod+K".focus-window-or-workspace-up = _: {};
            "Mod+Left".focus-column-left = _: {};
            "Mod+Right".focus-column-right = _: {};
            "Mod+Down".focus-workspace-down = _: {};
            "Mod+Up".focus-workspace-up = _: {};

            # Window movement
            "Mod+Shift+H".move-column-left = _: {};
            "Mod+Shift+L".move-column-right = _: {};
            "Mod+Shift+K".move-column-to-workspace-up = _: {};
            "Mod+Shift+J".move-column-to-workspace-down = _: {};
            "Mod+Shift+Ctrl+J".move-column-to-monitor-down = _: {};
            "Mod+Shift+Ctrl+K".move-column-to-monitor-up = _: {};

            # Resize
            "Mod+BracketLeft".set-column-width = "-10%";
            "Mod+BracketRight".set-column-width = "+10%";
            "Mod+Shift+BracketLeft".set-window-height = "-10%";
            "Mod+Shift+BracketRight".set-window-height = "+10%";

            # Workspaces
            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;

            # Screenshots
            "Print".screenshot = _: {};
            "Ctrl+Print".screenshot-screen = _: {};
            "Shift+Print".screenshot-window = _: {};
            "Mod+P".screenshot = _: {};
            "Mod+Ctrl+P".screenshot-screen = _: {};
            "Mod+Shift+P".screenshot-window = _: {};
          };
        };
      };
    };
}
