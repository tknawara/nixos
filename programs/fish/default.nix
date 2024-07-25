{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      ff = "fastfetch";
      ls = "eza";
      ll = "ls -lah";
      cat = "bat";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
  };
}
