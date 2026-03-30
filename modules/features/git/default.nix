{ inputs, ... }: {
  flake.hmModules.git = { config, pkgs, ... }:

    {
      programs.git = {
        enable = true;
        ignores = [ ".direnv/" ];
        signing.format = null;
        settings = {
          user = {
            name = "tknawara";
            email = "tarek.nawara@gmail.com";
          };
          alias = {
            lg1 =
              "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
            lg2 =
              "lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
            lg = "lg1";
          };
          init.defaultBranch = "main";
          core.editor = "hx";
        };
      };

      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          side-by-side = true;
          line-numbers = true;
          hyperlinks = true;
          hyperlinks-file-link-format =
            "vscode://file/{path}:{line}"; # opens links in vscode
        };
      };

      programs.gh.enable = true;
      programs.gh.settings.version = 1;
      programs.gh.settings.git_protocol = "https";
    };
}
