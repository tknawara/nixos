{ ... }: {
  flake.hmModules.gdb = { ... }: {
    home.file.".gdbinit".text = ''
      set tui
      set auto-load safe-path /nix/store
      set print pretty on
      set print array on
      set print elements 0
      set print object on
      set print static-members on
      set print vtbl on
      set pagination off
      set history save on
      set history size 10000
      set confirm off
      set disassembly-flavor intel
      set follow-fork-mode child
      set detach-on-fork off
      set print thread-events off
    '';
  };
}
