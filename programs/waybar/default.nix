{ config, pkgs, ... }:

{
  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 4;
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-right = [ "network" "cpu" "memory" "pulseaudio" ];
      modules-center = [ "clock" ];
      clock = {
        format = "{:%I:%M %p %A, %B %d, %Y}";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>'';
        format-alt = "{:%I:%M %p}";
      };
      cpu = { format = "{usage}% "; };
      memory = { format = "{}% "; };
      network = {
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} ";
        tooltip-format = ''
          {ifname} via {gwaddr} 
          up: {bandwidthUpBytes}
          down: {bandwidthDownBytes}'';
        format-linked = "{ifname} (No IP) ";
        format-disconnected = "Disconnected ⚠";
      };
      battery = {
        interval = 30;
        states = {
          full = 100;
          threeFour = 75;
          half = 50;
          critical = 25;
        };
        format-discharging-full = "{capacity}% 󰁹";
        format-discharging-threeFour = "{capacity}% 󰂀";
        format-discharging-half = "{capacity}% 󰁾";
        format-discharging-critical = "{capacity}% 󰂃";
        format-charging = "{capacity}% 󰂄";
        tooltip-format = ''
          {power} W
          {timeTo}'';
      };
      backlight = { format = "{percent}% "; };
      pulseaudio = {
        format = "{volume}% 󰓃";
        format-muted = "Muted 󰓄";
        format-bluetooth = "{volume}% 󰦢";
      };
    };
  };

  programs.waybar.style = ''
    * {
        border: none;
        font-family: Cousine Nerd Font;
        font-size: 15px;
    }

    window#waybar {
        background-color: rgba(57, 53, 82, 0);
        transition-property: background-color;
        transition-duration: .5s;
        opacity: 0.75;
    }

    #window {
      color: #e0def4;
      background-color: #232136;
      border: 2px solid #eb6f92;
      border-radius: 0 10px 10px 0;
      padding: 0px 10px 0px 10px;
    }

    window#waybar.empty #window {
      background-color: transparent;
    }

    window#waybar.hidden {
        opacity: 0.2;
    }

    #workspaces {
        background-color: #232136;
        border: 2px solid #eb6f92;
        border-radius: 10px 0 0 10px;
    }

    #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #908caa;
    }

    #workspaces button:hover {
        box-shadow: inherit;
        color: #eb6f92;
    }

    #workspaces button.active {
        color: #e0def4;
        border-radius: 10px;
    }

    #workspaces button.urgent {
        background-color: #eb6f92;
        color: #000000;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #network,
    #tray,
    #backlight,
    #pulseaudio {
        padding: 0 10px;
        color: #ffffff;
    }

    #clock {
        border-radius: 10px;
        background-color: #eb6f92;
        color: #000000;
    }

    #battery {
        background-color: #eb6f92;
        color: #000000;
        border-radius: 0 10px 10px 0;
    }

    #battery.charging {
        color: #000000;
        background-color: #f6c177;
    }

    #battery.critical:not(.charging) {
        background-color: #ea9a97;
        color: #ffffcc;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
    }

    label:focus {
        background-color: #000000;
    }

    #cpu,
    #memory,
    #backlight,
    #pulseaudio {
        background-color: #eb6f92;
        color: #000000;
    }

    #network {
        background-color: #eb6f92;
        border-radius: 10px 0 0 10px;
        color: #000000;
    }

    #network.disconnected {
        background-color: #3e8fb0;
    }

    #tray {
        background-color: transparent;
    }
  '';
}
