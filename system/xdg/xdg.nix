{
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/chrome" = "zen.desktop";
      "text/html" = "zen.desktop";
      "application/x-extension-htm" = "zen.desktop";
      "application/x-extension-html" = "zen.desktop";
      "application/x-extension-shtml" = "zen.desktop";
      "application/xhtml+xml" = "zen.desktop";
      "application/x-extension-xhtml" = "zen.desktop";
      "application/x-extension-xht" = "zen.desktop";
      "text/plain" = "zen-browser.desktop";
      "inode/directory" = "nemo.desktop";
      "application/x-gnome-saved-search" = "nemo.desktop";
      "image/png" = "viewnior.desktop";
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "image/jpeg" = "viewnior.desktop";
    };

    addedAssociations = {
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
      "x-scheme-handler/http" = ["zen.desktop" "zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "x-scheme-handler/https" = ["zen.desktop" "zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "x-scheme-handler/chrome" = ["zen.desktop" "zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "text/html" = ["zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "application/x-extension-htm" = ["zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "application/x-extension-html" = ["zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "application/x-extension-shtml" = ["zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "application/xhtml+xml" = ["zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "application/x-extension-xhtml" = ["zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "application/x-extension-xht" = ["zen-browser.desktop" "zen-alpha.desktop" "zen-beta.desktop" "userapp-Zen-X27G02.desktop"];
      "text/plain" = ["neovide.desktop" "dev.zed.Zed.desktop" "zen-browser.desktop" "userapp-lvim-DQMET2.desktop" "lvim.desktop" "vim.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["onlyoffice-desktopeditors.desktop"];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["onlyoffice-desktopeditors.desktop"];
      "image/png" = ["org.gnome.Loupe.desktop" "yazi.desktop"];
      "text/x-log" = ["lvim.desktop"];
      "image/svg+xml" = ["ephoto.desktop" "viewnior.desktop"];
      "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      "text/x-java-source" = ["nvim.desktop"];
      "image/jpeg" = ["viewnior.desktop"];
    };
  };
}
