{ self, inputs, ... }:
let
  noctalia-shell = inputs.noctalia-shell;
in {
  perSystem = { pkgs, system, ... }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = {
        package = noctalia-shell.packages.${system}.default;
      } // (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
    };
  };
}
