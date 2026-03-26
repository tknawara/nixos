{ inputs, ... }: {
  imports = [
    (inputs.import-tree ./hosts)
    (inputs.import-tree ./features)
  ];
}
