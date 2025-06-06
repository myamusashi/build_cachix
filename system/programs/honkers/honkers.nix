let
  aagl-gtk-on-nix = import (fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "0z9lg60k9f58asx6myz25ysp3finfa8yrzz6ars2lasi5zhvg4s9";
  });
in {
  imports = [aagl-gtk-on-nix.module];

  programs.honkers-railway-launcher.enable = true;
}
