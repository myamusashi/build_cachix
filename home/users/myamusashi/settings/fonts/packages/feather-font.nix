{
  lib,
  stdenv,
  fetchgit,
}: let
  version = "1.0";
in
  stdenv.mkDerivation {
    version = "${version}";
    name = "feather-font-${version}";

    src = fetchgit {
      url = "https://github.com/dustinlyons/feather-font.git";
      rev = "refs/tags/${version}";
      sparseCheckout = ["feather.ttf"];
      hash = "sha256-Zsz8/qn7XAG6BVp4XdqooEqioFRV7bLH0bQkHZvFbsg=";
    };

    installPhase = ''
      # Create the standard fonts directory structure
      mkdir -p $out/share/fonts/truetype/feather

      # Install the font with appropriate permissions
      install -Dm644 ./feather.ttf $out/share/fonts/truetype/feather/feather.ttf
    '';

    meta = with lib; {
      description = "Feather icon font";
      license = licenses.mit;
      platforms = platforms.all;
    };
  }
