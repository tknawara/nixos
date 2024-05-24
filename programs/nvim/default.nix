{ pkgs, config, fetchFromGitHub, ... }:

{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    extraPython3Packages = (ps: with ps; [ pynvim tasklib six packaging ]);
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.file.".config/nvim" = {
    source = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "starter";
      rev = "aad624221adc6ed4e14337b3b3f2b74136696b53";
      hash = "sha256-2HNqPdnIVkX+d5OxjsRbL3SoY8l5Ey7/Y274Pi5uZW4=";
    };
    recursive = true;
  };
}
