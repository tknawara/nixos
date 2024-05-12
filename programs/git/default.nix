{ config, inputs, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "tknawara";
    userEmail = "tarek.nawara@gmail.com";
    aliases = {
      lg1 =
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
      lg2 =
        "lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      lg = "lg1";
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
        hyperlinks = true;
        hyperlinks-file-link-format =
          "vscode://file/{path}:{line}"; # opens links in vscode
      };
    };
  };
}
