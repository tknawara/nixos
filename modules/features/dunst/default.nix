{ pkgs, config, ... }:

{
  services.dunst = {
    enable = true;
    settings = { global = { font = "${config.font.monospace.name} 9"; }; };
  };
}
