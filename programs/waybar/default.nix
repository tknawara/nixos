{ config, pkgs, inputs, ... }:

{
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 20;

      # modules-left = [ "hyprland/workspaces" "hyprland/submap" ];
      modules-left = [ "niri/workspaces" ];
      modules-center = [ ];
      modules-right = [
        # "idle_inhibitor"
        #"bluetooth"
        "group/power-group"
        # "custom/vpn"
        "network"
        "cpu"
        "memory"
        "pulseaudio"
        "clock"
        #"backlight"
        # "tray"
      ];

      backlight = {
        format = "{icon}  {percent}%";
        format-icons = [ "" "" ];
        tooltip = true;
      };

      battery = {
        interval = 10;
        states = {
          "good" = 95;
          "warning" = 25;
          "critical" = 15;
        };
        format = "{icon}  {capacity}% {time}";
        format-icons = [
          "" # battery-full
          "" # battery-three-quarters
          "" # battery-half
          "" # battery-quarter
          "" # battery-empty
        ];
        tooltip = true;
      };

      bluetooth = {
        format = "{icon}  {status}";
        interval = 30;
        format-icons = {
          enabled = "";
          disabled = "";
        };
        tooltip-format = "bluetooth {status}";
        on-click = "${pkgs.blueman}/bin/blueman-manager";
      };

      clock = {
        interval = 1;
        format = "  {:%Y-%m-%d %H:%M:%S}"; # Icon: calendar-alt
        on-click = "${pkgs.gnome-calendar}/bin/gnome-calendar";
        tooltip = false;
      };

      "clock#time" = {
        interval = 1;
        format = "{:%H:%M:%S}";
        tooltip = false;
      };

      "clock#date" = {
        interval = 60;
        format = "  {:%Y-%m-%d}"; # Icon: calendar-alt
      };

      cpu = {
        interval = 5;
        format = "  {usage}% ({load})"; # Icon: microchip
        states = {
          warning = 70;
          critical = 90;
        };
        on-click =
          "wezterm -e ${pkgs.bash}/bin/bash -ci htop --sort-key PERCENT_CPU";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        tooltip = true;
      };

      memory = {
        interval = 5;
        format =
          "  {}% ({used}G  {avail}G  {swapPercentage}%󰓢)"; # Icon: memory
        states = {
          warning = 70;
          critical = 90;
        };
        on-click =
          "wezterm -e ${pkgs.bash}/bin/bash -ci htop --sort-key PERCENT_MEM";
        tooltip = true;
      };

      network = {
        interval = 5;
        format-wifi = "  {signalStrength}%"; # Icon: wifi
        format-ethernet = "  {ifname}: {ipaddr}/{cidr}"; # Icon: ethernet
        format-disconnected = "⚠  Disconnected";
        tooltip-format = "{ifname}: {ipaddr}";
        on-click =
          "wezterm -e ${pkgs.bash}/bin/bash -ci ${pkgs.networkmanager}/bin/nmtui";
      };

      "hyprland/window" = {
        format = "{}";
        max-length = 120;
      };

      "hyprland/workspaces" = {
        all-outputs = false;
        disable-scroll = true;
      };

      "hyprland/submap" = {
        format = "✌️ {}";
        max-length = 20;
        tooltip = false;
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-bluetooth = "{icon}  {volume}%";
        format-muted = "";
        format-icons = {
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      temperature = {
        critical-threshold = 80;
        interval = 5;
        format = "{icon}  {temperatureC}°C";
        format-icons = [
          "" # Icon: temperature-empty
          "" # Icon: temperature-quarter
          "" # Icon: temperature-half
          "" # Icon: temperature-three-quarters
          "" # Icon: temperature-full
        ];
        tooltip = true;
      };

      tray = {
        icon-size = 21;
        spacing = 10;
      };

      "custom/vpn" = {
        format = "{icon}  {alt}";
        tooltip-format = "{}";
        exec = pkgs.writeShellScript "waybar-vpn" ''
          if [ -d /proc/sys/net/ipv4/conf/tun0 ]; then
            conn=$( \
              ${pkgs.networkmanager}/bin/nmcli c show --active \
                | ${pkgs.gnugrep}/bin/grep ' vpn ' \
                | ${pkgs.coreutils}/bin/head -n1 \
                | ${pkgs.gawk}/bin/awk '{print $1}' \
            )
            echo "{\"text\":\"Connected\", \"alt\":\"$conn\", \"class\":\"on\", \"percentage\":100}"
          else
            echo '{"text":"Disconnected", "alt":"vpn", "class":"off", "percentage":0}'
          fi
        '';
        return-type = "json";
        interval = 5;
        format-icons = [ "" "" ];
        on-click = ''
          wezterm -e ${pkgs.bash}/bin/bash -ci "${pkgs.networkmanager}/bin/nmtui connect"'';
      };

      "wlr/taskbar" = {
        format = "{icon}";
        all-outputs = false;
        on-click = "activate";
        on-middle-click = "close";
        rewrite = { "Firefox Web Browser" = "Firefox"; };
      };

      "group/power-group" = {
        "orientation" = "inherit";
        "drawer" = {
          "transition-duration" = 500;
          "children-class" = "not-power";
          "transition-left-to-right" = true;
        };
        "modules" = [
          "custom/power"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
          "custom/suspend"
        ];
      };

      "custom/quit" = {
        format = "󰗼";
        tooltip = true;
        on-click = "niri msg action quit";
        tooltip-format = "Logout";
      };
      "custom/lock" = {
        format = "󰍁";
        tooltip = true;
        on-click = "hyprlock";
        tooltip-format = "Lock Screen";
      };
      "custom/reboot" = {
        format = "󰜉";
        tooltip = true;
        on-click = "systemctl reboot";
        tooltip-format = "Reboot";
      };
      "custom/power" = {
        format = "";
        tooltip = true;
        on-click = "systemctl poweroff";
        tooltip-format = "Shutdown";
      };
      "custom/suspend" = {
        format = "󰤄";
        tooltip = true;
        on-click = "systemctl suspend && hyprlock --immediate";
        tooltip-format = "Suspend";
      };
    };
  };

  programs.waybar.style = # css
    ''
      @import "${inputs.catppuccin-waybar}/themes/mocha.css";

      /* Reset all styles */
      * {
        color: @text;
        border: none;
        border-radius: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
      }

      /* The whole bar */
      #waybar {
        background-color: shade(@base, 0.9);
        border: 2px solid alpha(@crust, 0.3);
        color: @text;
        font-family: UbuntuMono Nerd Font, Hack, Ubuntu; 
        font-size: 16px; 
      }

      #workspaces {
        border-right: 1px solid @crust;
      }
      #workspaces button {
        padding: 0 5px;
        border-left: 1px solid @mantle;
      }
      #workspaces button.visible {
        color: @peach;
        border-bottom: 2px solid @peach;
      }
      #workspaces button.focused {
        color: @green;
        border-bottom: 2px solid @green;
      }
      /*
        * https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect
        */
      #workspaces button:hover {
        color: @pink;
        border-bottom: 2px solid @pink;
        background-color: transparent;
      }
      #workspaces button.urgent {
        color: @red;
      }
      #submap {
        color: @maroon;
      }

      /* Each module */
      #backlight,
      #custom-power,
      #custom-quit,
      #custom-lock,
      #custom-reboot,
      #custom-suspend,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #custom-keyboard-layout,
      #custom-vpn,
      #idle_inhibitor,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
        padding-left: 10px;
        padding-right: 10px;
        margin-left: 2px;
        margin-right: 2px;
        border-radius: 8px;
      }


      /* -----------------------------------------------------------------------------
        * Module styles
        * -------------------------------------------------------------------------- */

      #bluetooth {  color: #ffffff; background-color: @blue; }
      #backlight {  color: @yellow; }
      #tray {       background-color: transparent; }


      #battery {
          color: @green;
      }
      #battery.warning {
      }
      #battery.critical {
      }
      #battery.warning.discharging {
        background-color: @maroon;
        animation-name: blink-warning;
        animation-duration: 3s;
      }
      #battery.critical.discharging {
        background-color: @red;
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #clock {
        color: @lavender; 
        margin-left: 8px;
        margin-right: 8px;
        padding-right: 8px;
        padding-left: 8px;
      }

      #cpu {
        color: @sapphire;
        padding-right: 8px;
        padding-left: 8px;
      }
      #cpu.warning {
      }
      #cpu.critical {
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #custom-vpn {
      }
      #custom-vpn.on {  
        color: @mauve;  
      }
      #custom-vpn.off {
        color: @crust;
      }
      #custom-vpn.connected {
      }
      #custom-vpn.disconnected {
          color: @crust;
      }

      #memory {
        color: @sky;
        padding-left: 8px;
        padding-right: 8px;
      }
      #memory.warning {
      }
      #memory.critical {
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      #mode {
        background: #64727D;
        border-top: 2px solid white;
        /* To compensate for the top border and still have vertical centering */
        padding-bottom: 2px;
      }

      #network {
        color: @lavender;
        padding-left: 8px;
        padding-right: 8px;
      }
      #network.disconnected {
        color: @read;
      }

      #pulseaudio {
        color: @teal;
        padding-left: 8px;
        padding-right: 8px;
      }
      #pulseaudio.muted {
      }

      #custom-power {
        color: @maroon;
        font-size: 16px;
        border-radius: 19px;
      }

      #custom-quit {
        color: @yellow;
        font-size: 16px;
        border-radius: 19px;
      }

      #custom-lock {
        color: @peach;
        font-size: 16px;
        border-radius: 19px;
      }

      #custom-reboot {
        color: @flamingo;
        font-size: 16px;
        border-radius: 19px;
      }

      #custom-suspend {
        color: @lavender;
        font-size: 16px;
        border-radius: 19px;
      }

      #custom-spotify {
        color: rgb(102, 220, 105);
      }

      #temperature {
      }
      #temperature.critical {
        background-color: @red;
      }

      #tray {
        border-left: 1px solid @mantle;
        border-right: 1px solid @mantle;
      }

      #window {
        font-weight: bold;
        padding-left: 10px;
      }

    '';
}
