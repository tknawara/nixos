{ pkgs, lib, ... }:
let inherit (lib) mkOption types;
in {
  options = {
    cursor = mkOption {
      type = types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            default = "Bibata-Modern-Classic";
          };
          package = mkOption {
            type = types.package;
            default = pkgs.bibata-cursors;
          };
          size = mkOption {
            type = types.int;
            default = 14;
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
