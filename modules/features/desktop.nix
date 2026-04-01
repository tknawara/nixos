{ ... }: {
  flake.hmModules.desktop = { pkgs, ... }:
    let browser = "brave-browser.desktop";
    in {

      xdg.mimeApps = {
        enable = true;
        associations.added = {
          "application/x-extension-htm" = [ browser ];
          "application/x-extension-html" = [ browser ];
          "application/x-extension-shtml" = [ browser ];
          "application/x-extension-xht" = [ browser ];
          "application/x-extension-xhtml" = [ browser ];
          "application/xhtml+xml" = [ browser ];
          "audio/*" = [ "vlc.desktop" ];
          "text/html" = [ browser ];
          "video/*" = [ "vlc.desktop" ];
          "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
          "x-scheme-handler/chrome" = [ browser ];
          "x-scheme-handler/http" = [ browser ];
          "x-scheme-handler/https" = [ browser ];
        };
        defaultApplications = {
          "application/x-extension-htm" = [ browser ];
          "application/x-extension-html" = [ browser ];
          "application/x-extension-shtml" = [ browser ];
          "application/x-extension-xht" = [ browser ];
          "application/x-extension-xhtml" = [ browser ];
          "application/xhtml+xml" = [ browser ];
          "text/html" = [ browser ];
          "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
          "x-scheme-handler/chrome" = [ browser ];
          "x-scheme-handler/http" = [ browser ];
          "x-scheme-handler/https" = [ browser ];
        };
      };
    };
}
