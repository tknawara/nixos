{ pkgs, inputs, ... }:
let nix-index-pkg = inputs.nix-index.packages.${pkgs.system}.default;
in {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    extraConfig = # nu
      ''
        $env.config.hooks.command_not_found = source ${nix-index-pkg}/etc/profile.d/command-not-found.nu
      '';
    shellAliases = {
      ff = "fastfetch";
      cat = "bat";
      grep = "rg";
      update = "sudo nixos-rebuild switch --flake /home/tarek/nixos#default";
    };
    plugins = with pkgs.nushellPlugins; [
      polars
      query
      gstat
      units
      formats
      highlight
    ];
  };
}
