{ ... }: {
  flake.hmModules.hyprlock = { pkgs, config, ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [{ path = "${config.wallpaper}"; }];
    };
  };
}; };
