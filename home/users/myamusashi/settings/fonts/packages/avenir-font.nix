{
  lib,
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation rec {
  pname = "avenir-lt-pro";
  version = "2.0";

  src = fetchzip {
    url = "https://font.download/dl/font/${pname}.zip";
    hash = "sha256-muTE39N6pTKgpiF+7ikAwycReBFCrnwf0Syik5Wddvs=";
    stripRoot = false;
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype/${pname}
    install -Dm644 $src/*.otf -t $out/share/fonts/opentype/${pname}/

    runHook postInstall
  '';

  meta = with lib; {
    description = "";
    homepage = "";
    maintainers = [myamusashi];
  };
}
