{ pkgs, ... }:
let browser = "firefox.desktop";
in {

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/x-extension-htm" = [ browser ];
      "application/x-extension-html" = [ browser ];
      "application/x-extension-shtml" = [ browser ];
      "application/x-extension-xht" = [ browser ];
      "application/x-extension-xhtml" = [ browser ];
      "application/xhtml+xml" = [ "org.gnome.Epiphany.desktop" browser ];
      "audio/*" = [ "vlc.desktop" ];
      "text/html" = [ "org.gnome.Epiphany.desktop" browser ];
      "video/*" = [ "vlc.dekstop" ];
      "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
      "x-scheme-handler/chrome" = [ browser ];
      "x-scheme-handler/http" = [ "org.gnome.Epiphany.desktop" browser ];
      "x-scheme-handler/https" = [ "org.gnome.Epiphany.desktop" browser ];
    };
    defaultApplications = {
      "application/x-extension-htm" = [ browser ];
      "application/x-extension-html" = [ browser ];
      "application/x-extension-shtml" = [ browser ];
      "application/x-extension-xht" = [ browser ];
      "application/x-extension-xhtml" = [ browser ];
      "application/xhtml+xml" = [ browser ];
      "text/html" = [ browser ];
      "x-scheme-handler/anytype" = [ "anytype.desktop" ];
      "x-scheme-handler/appflowy-flutter" = [ "appflowy.desktop" ];
      "x-scheme-handler/chrome" = [ browser ];
      "x-scheme-handler/http" = [ browser ];
      "x-scheme-handler/https" = [ browser ];
    };
  };
}
