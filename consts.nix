{ pkgs, lib, ... }:
let inherit (lib) mkOption types;
in {
  options = {
    font = mkOption {
      type = types.submodule {
        options = {
          monospace = mkOption {
            type = types.submodule {
              options = {
                name = mkOption {
                  type = types.str;
                  default = "Cascadia Code NF";
                };
                package = mkOption {
                  type = types.package;
                  default = pkgs.cascadia-code;
                };
              };
            };
            default = { };
          };
          serif = mkOption {
            type = types.submodule {
              options = {
                name = mkOption {
                  type = types.str;
                  default = "Inter Variable Serif";
                };
                package = mkOption {
                  type = types.package;
                  default = pkgs.inter;
                };
              };
            };
            default = { };
          };
          sansSerif = mkOption {
            type = types.submodule {
              options = {
                name = mkOption {
                  type = types.str;
                  default = "Inter Variable Sans Serif";
                };
                package = mkOption {
                  type = types.package;
                  default = pkgs.inter;
                };
              };
            };
            default = { };
          };
        };
      };

      default = { };
    };

    image = mkOption {
      type = types.path;
      default = ./wallpapers/single-mountain-landscape.jpg;
    };
  };

  config = { };
}
