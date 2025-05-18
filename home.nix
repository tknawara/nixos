{ config, pkgs, inputs, ... }:

{

  imports = [
    ./consts.nix
    ./desktop.nix
    ./programs/atuin/default.nix
    ./programs/carapace/default.nix
    ./programs/direnv/default.nix
    ./programs/dunst/default.nix
    ./programs/emacs/default.nix
    ./programs/fish/default.nix
    ./programs/gdb/default.nix
    ./programs/ghostty/default.nix
    ./programs/git/default.nix
    ./programs/helix/default.nix
    ./programs/hyprland/default.nix
    ./programs/hyprlock/default.nix
    ./programs/index/default.nix
    ./programs/kitty/default.nix
    ./programs/neovide/default.nix
    ./programs/niri/default.nix
    ./programs/nushell/default.nix
    ./programs/nvim/default.nix
    ./programs/rofi/default.nix
    ./programs/starship/default.nix
    ./programs/superfile/default.nix
    ./programs/tmux/default.nix
    ./programs/ui/default.nix
    ./programs/vscode/default.nix
    ./programs/waybar/default.nix
    ./programs/wezterm/default.nix
    ./programs/zededitor/default.nix
    ./programs/zellij/default.nix
    ./programs/zoxide/default.nix
    ./programs/zsh/default.nix
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

    neovide
    serpl
    adw-gtk3
    any-nix-shell
    appflowy
    bat
    binsider
    blueman
    cliphist
    delta
    discord
    docker
    eza
    fastfetch
    fh
    firefox
    fzf
    ghostty
    git
    gnome-tweaks
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gnome-40-ui-improvements
    grim
    gsimplecal
    htop
    hyprlock
    hyprshot
    jdk
    jetbrains.idea-community-bin
    libnotify
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
    rofi-wayland
    sapling
    slurp
    swww
    unzip
    vlc
    wl-clipboard
    yazi
    zoom-us
    zplug
    zsh

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
