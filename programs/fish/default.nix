{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
    shellAliases = {
      ff = "fastfetch";
      ls = "eza";
      ll = "ls -lah";
      cat = "bat";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
  };
}
