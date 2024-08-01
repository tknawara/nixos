{ pkgs, config, ... }:

{
  services.dunst = {
    enable = true;
    settings = { global = { font = "${config.font.sansSerif.name} 10"; }; };
  };
}
