{ pkgs, config, ... }: {
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
}
