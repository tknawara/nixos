{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        # Use v2 settings to avoid deprecation warnings
        v2-settings = true;

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

        outputs."*" = {
          scale = 1.5;
          mode = "3840x2160@120";
        };

        prefer-no-csd = _: {};

        spawn-at-startup = [
          # Noctalia disabled due to upstream quickshell build issue
          # [ (lib.getExe pkgs.noctalia-shell) ]
          [ (lib.getExe pkgs.xwayland-satellite) ]
          [ "${pkgs.clipse}/bin/clipse" "-listen" ]
          [ "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1" ]
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          keyboard.xkb.layout = "us";
          focus-follows-mouse.enable = false;
        };

        layout = {
          gaps = 5;
          focus-ring = {
            enable = true;
            width = 0.1;
          };
          default-column-width = { proportion = 0.5; };
        };

        window-rules = [{
          matches = [{ app-id = "^clipse$"; }];
          open-floating = true;
        }];

        binds = {
          "Mod+Return".spawn.command = [ "wezterm" ];
          "Mod+Q".close-window = _: {};
          "Mod+Space".spawn.command = [ (lib.getExe self'.packages.vicinae) ];
          "Mod+C".spawn.command = [ "wezterm" "start" "--class" "clipse" "-e" "clipse" ];

          "Mod+Shift+E".quit = _: {};
          "Mod+Shift+Slash".show-hotkey-overlay = _: {};

          "Mod+H".focus-column-left = _: {};
          "Mod+L".focus-column-right = _: {};
          "Mod+J".focus-window-or-workspace-down = _: {};
          "Mod+K".focus-window-or-workspace-up = _: {};

          "Mod+Shift+H".move-column-left = _: {};
          "Mod+Shift+L".move-column-right = _: {};

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          "Print".screenshot = _: {};
          "Mod+P".screenshot = _: {};
        };
      };
    };
  };
}
