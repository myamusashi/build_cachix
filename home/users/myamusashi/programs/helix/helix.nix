{pkgs, ...}: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      alejandra
      lemminx
      nil # nix lsp
      svelte-language-server
      gopls
      nixd
      gnumake
      mesonlsp
      sassc
      ccls
      sqls
      dockerfile-language-server-nodejs
      jdt-language-server
      google-java-format
      vscode-langservers-extracted
      llvmPackages_19.clang-unwrapped # C stuff
      typescript-language-server
      sqls
      sass
      lua54Packages.luarocks_bootstrap
      stylua
      typescript
      nodejs-slim_22
      dockerfile-language-server-nodejs
      fish-lsp
      python312Packages.python-lsp-server
      pyright
      rust-analyzer
      marksman
      tailwindcss-language-server
      vscode-langservers-extracted # html, css, json, eslint
      bash-language-server
      shfmt # shell format
      prettierd # html, css, json formatting
      lua-language-server
    ];
    settings = {
      theme = "base16";
      themes = {
        base16 = let
          transparent = "none";
          gray = "#727169";
          dark-gray = "#363646";
          white = "#DCD7BA";
          black = "#16161D";
          red = "#FF5D62";
          green = "#98BB6C";
          yellow = "#FABD2F";
          orange = "#FFA066";
          blue = "#7FB4CA";
          magenta = "#D27E99";
          cyan = "#7E9CD8";
        in {
          "ui.menu" = transparent;
          "ui.menu.selected" = {modifiers = ["reversed"];};
          "ui.linenr" = {
            fg = gray;
            bg = dark-gray;
          };
          "ui.popup" = {modifiers = ["reversed"];};
          "ui.linenr.selected" = {
            fg = white;
            bg = black;
            modifiers = ["bold"];
          };
          "ui.selection" = {
            fg = black;
            bg = blue;
          };
          "ui.selection.primary" = {modifiers = ["reversed"];};
          "comment" = {fg = gray;};
          "ui.statusline" = {
            fg = white;
            bg = dark-gray;
          };
          "ui.statusline.inactive" = {
            fg = dark-gray;
            bg = white;
          };
          "ui.help" = {
            fg = dark-gray;
            bg = white;
          };
          "ui.cursor" = {modifiers = ["reversed"];};
          "variable" = red;
          "variable.builtin" = orange;
          "constant.numeric" = orange;
          "constant" = orange;
          "attributes" = yellow;
          "type" = yellow;
          "ui.cursor.match" = {
            fg = yellow;
            modifiers = ["underlined"];
          };
          "string" = green;
          "variable.other.member" = red;
          "constant.character.escape" = cyan;
          "function" = blue;
          "constructor" = blue;
          "special" = blue;
          "keyword" = magenta;
          "label" = magenta;
          "namespace" = blue;
          "diff.plus" = green;
          "diff.delta" = yellow;
          "diff.minus" = red;
          "diagnostic" = {modifiers = ["underlined"];};
          "ui.gutter" = {bg = black;};
          "info" = blue;
          "hint" = dark-gray;
          "debug" = dark-gray;
          "warning" = yellow;
          "error" = red;
        };
      };
      editor = {
        line-number = "relative";
        lsp.display = "";
      };
    };
  };
}
