{pkgs-stable, ...}: {
  programs.starship = {
    enable = true;
    settings = pkgs-stable.lib.importTOML ./starship.toml;
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      set -gx EDITOR 'nvim -u $HOME/.config/nvim/init.lua'
      set -g fish_greeting

      ${pkgs-stable.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      function imgcp
        wl-copy < $argv[1]
      end
    '';
    interactiveShellInit = ''
      alias ls "eza --icons"
      alias l "ls -alh"
      alias ll "ls -l"
    '';
  };

  programs.command-not-found.enable = true;
}
