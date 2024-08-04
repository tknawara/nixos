{ pkgs, config, ... }:

{
  services.dunst = {
    enable = true;
    settings = { global = { font = "Droid Sans 9"; }; };
  };
}
