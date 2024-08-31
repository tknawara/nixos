{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    shellAliases = {
      ff = "fastfetch";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
  };
}
