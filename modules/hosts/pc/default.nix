{ self, inputs, ... }: {
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs self; };
    modules = [
      self.nixosModules.pcConfiguration
      inputs.home-manager.nixosModules.default
      inputs.catppuccin.nixosModules.catppuccin
    ];
  };

  flake.nixosModules.pcConfiguration = { pkgs, lib, ... }: {
    imports = [
      ./configuration.nix
      ./hardware.nix
      ./consts.nix
      # System-level features
      self.nixosModules.niri
      self.nixosModules.shell
      self.nixosModules.essentials
      self.nixosModules.vicinae
    ];

    # Home Manager configuration
    home-manager = {
      extraSpecialArgs = { inherit inputs self; };
      users.tarek = {
        imports = [
          inputs.catppuccin.homeModules.catppuccin
          ./consts.nix
          # Home Manager features
          self.hmModules.desktop
          self.hmModules.atuin
          self.hmModules.carapace
          self.hmModules.direnv
          self.hmModules.emacs
          self.hmModules.fish
          self.hmModules.gdb
          self.hmModules.ghostty
          self.hmModules.git
          self.hmModules.helix
          self.hmModules.hyprland
          self.hmModules.index
          self.hmModules.neovide
          self.hmModules.nushell
          self.hmModules.nvim
          self.hmModules.starship
          self.hmModules.superfile
          self.hmModules.tmux
          self.hmModules.ui
          self.hmModules.vscode
          self.hmModules.wezterm
          self.hmModules.zededitor
          self.hmModules.zellij
          self.hmModules.zoxide
          self.hmModules.zsh
        ];

        home.username = "tarek";
        home.homeDirectory = "/home/tarek";
        home.stateVersion = "23.11";

        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.allowUnfreePredicate = (_: true);

        home.packages = with pkgs; [
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
          grim
          gsimplecal
          htop
          hyprshot
          jdk
          jetbrains.idea-community-bin
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
          zoom-us
        ];

        catppuccin.flavor = "mocha";
        catppuccin.enable = true;

        home.file.".config/nixpkgs/config.nix".text = ''
          {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          }
        '';

        home.sessionVariables = { EDITOR = "hx"; };

        programs.home-manager.enable = true;
      };
    };
  };
}
