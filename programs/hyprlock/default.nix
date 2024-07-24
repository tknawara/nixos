{ pkgs, config, ... }: {

  programs.hyprlock = {
    enable = true;

    settings = {
      general = { hide_cursor = true; };

      background = {
        monitor = "";
        path = "${config.stylix.image}";

        blur_size = 2;
        blur_passes = 3; # 0 disables blurring;;
        noise = 1.17e-2;
        contrast = 1.3; # Vibrant!!!
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        # monitor =
        size = {
          width = 250;
          hight = 50;
        };
        outline_thickness = 2;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.64; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        fade_on_empty = true;
        placeholder_text =
          "<i></i>"; # Text rendered in the input box when it's empty.
        hide_input = false;
        position = {
          x = 0;
          y = 275;
        };
        halign = "center";
        valign = "bottom";
      };

      # Current time
      label = {
        monitor = "";
        text = ''cmd[update:1000] echo "$(date +"%R")"'';
        position = {
          x = 0;
          y = 16;
        };
        halign = "center";
        valign = "center";
      };
    };
  };
}
