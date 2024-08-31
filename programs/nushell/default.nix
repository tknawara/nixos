{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    shellAliases = {
      ff = "fastfetch";
      cat = "bat";
      grep = "rg";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
  };
}
