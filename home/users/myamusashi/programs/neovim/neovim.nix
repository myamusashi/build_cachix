{
  inputs,
  pkgs,
  ...
}: {
  imports = [./neovide.nix];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      (nvim-treesitter.withPlugins (
        plugins:
          with plugins; [
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-dockerfile
            tree-sitter-fish
            tree-sitter-go
            tree-sitter-html
            tree-sitter-svelte
            tree-sitter-json
            tree-sitter-lua
            tree-sitter-nix
            tree-sitter-sql
            tree-sitter-python
            tree-sitter-r
            tree-sitter-dockerfile
            tree-sitter-java
            tree-sitter-regex
            tree-sitter-rust
            tree-sitter-toml
            tree-sitter-vim
            tree-sitter-yaml
            tree-sitter-toml
          ]
      ))
    ];
    extraPackages = with pkgs; [
      alejandra
      vimPlugins.nvim-treesitter-parsers.kconfig
      lemminx
      nil # nix lsp
      svelte-language-server
      gopls
      pnpm_10
      yarn
      nodejs_22
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
      gcc14
      libgcc
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
      markdownlint-cli
      markdownlint-cli2
      live-server
      rust-analyzer
      marksman
      tailwindcss-language-server
      vscode-langservers-extracted # html, css, json, eslint
      bash-language-server
      shfmt # shell format
      prettierd # html, css, json formatting
      lua-language-server
    ];
  };
}
