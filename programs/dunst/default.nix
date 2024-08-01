{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = { global = { font = "UbuntuMono Nerd Font 10"; }; };
  };
}
