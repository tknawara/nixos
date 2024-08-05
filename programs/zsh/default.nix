{ config, inputs, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = # zsh
      ''
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        any-nix-shell zsh --info-right | source /dev/stdin
      '';

    shellAliases = {
      ff = "fastfetch";
      ls = "eza";
      ll = "ls -lah";
      cat = "bat";
      em = "emacsclient -n";
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
