{ ... }: {
  home.file.".gdbinit".text = ''
    set tui
    set auto-load safe-path /nix/store
  '';
}
