{ self, inputs, ... }: {
  # Noctalia shell wrapper (currently disabled due to upstream quickshell build issue)
  perSystem = { pkgs, system, ... }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
    };
  };
}
