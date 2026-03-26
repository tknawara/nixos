{ config, pkgs, inputs, ... }:

{

  imports = [
    ./modules/hosts/pc/consts.nix
    ./modules/features/desktop.nix
    ./modules/features/atuin/default.nix
    ./modules/features/carapace/default.nix
    ./modules/features/direnv/default.nix
    ./modules/features/dunst/default.nix
    ./modules/features/emacs/default.nix
    ./modules/features/fish/default.nix
    ./modules/features/gdb/default.nix
    ./modules/features/ghostty/default.nix
    ./modules/features/git/default.nix
    ./modules/features/helix/default.nix
    ./modules/features/hyprland/default.nix
    ./modules/features/hyprlock/default.nix
    ./modules/features/index/default.nix
    ./modules/features/kitty/default.nix
    ./modules/features/neovide/default.nix
    ./modules/features/niri/default.nix
    ./modules/features/nushell/default.nix
    ./modules/features/nvim/default.nix
    ./modules/features/rofi/default.nix
    ./modules/features/starship/default.nix
    ./modules/features/superfile/default.nix
    ./modules/features/tmux/default.nix
    ./modules/features/ui/default.nix
    ./modules/features/vscode/default.nix
    ./modules/features/waybar/default.nix
    ./modules/features/wezterm/default.nix
    ./modules/features/zededitor/default.nix
    ./modules/features/zellij/default.nix
    ./modules/features/zoxide/default.nix
    ./modules/features/zsh/default.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tarek";
  home.homeDirectory = "/home/tarek";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    popsicle
    xwayland-satellite
    clipse
    _1password-gui
    serpl
    adw-gtk3
    appflowy
    bat
    binsider
    delta
    discord
    docker
    eza
    fastfetch
    fh
    firefox
    fzf
    # git
    # gnome-tweaks
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.gnome-40-ui-improvements
    grim
    gsimplecal
    htop
    # hyprlock
    hyprshot
    jdk
    jetbrains.idea-community-bin
    # libnotify
    libsecret
    lua
    nil
    nixfmt-classic
    (obsidian.override (prev: {
      commandLineArgs = (prev.commandLineArgs or "")
        + " --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland --enable-wayland-ime";
    }))
    papirus-icon-theme
    pavucontrol
    ripgrep
    sapling
    slurp
    unzip
    vlc
    # yazi
    zoom-us
    # zplug
    # zsh

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # programs.java = { enable = true; };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Theming
  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  home.file.".config/nixpkgs/config.nix".text = # nix
    ''
      {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      }
    '';

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tarek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "hx"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
