{ config, inputs, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      any-nix-shell zsh --info-right | source /dev/stdin
    '';

    shellAliases = {
      ff = "fastfetch";
      ls = "eza";
      ll = "ls -lah";
      cat = "bat";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
    zplug = {
      enable = true;
      plugins = [ ];
    };
  };
}
