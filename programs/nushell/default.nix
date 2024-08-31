{ pkgs, ... }:

{
  programs.nushell = {
    enable = true;
    shellAliases = {
      ff = "fastfetch";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
  };
}
