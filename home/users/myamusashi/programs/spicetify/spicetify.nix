{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.spicetify];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      shuffle
      adblockify
      betterGenres
      copyToClipboard
    ];
    theme = spicePkgs.themes.hazy;
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
  };
}
