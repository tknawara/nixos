{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block
    '';
    shellAliases = {
      ff = "fastfetch";
      ls = "eza";
      ll = "ls -lah";
      cat = "bat";
      em = "emacsclient -n";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
  };
}
