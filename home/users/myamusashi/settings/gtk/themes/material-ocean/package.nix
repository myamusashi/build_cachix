{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  pname = "Material-GTK-Themes";

  src = fetchFromGitHub {
    owner = "Fausto-Korpsvart";
    repo = "${pname}";
    rev = "4d828d5d85bff3307a228c837b9f4fa165a7c30a";
    hash = "sha256-2E+ZRnvqzzS986J0ckrV73J1YqMUodj8bVXVStxcfUg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes
    cp ./themes/Material-DeepOcean-B $out/share/themes

    runHook postInstall
  '';

  meta = with lib; {
    description = "Material GTK Themes";
    homepage = "https://github.com/Fausto-Korpsvart/Material-GTK-Themes";
    license = licenses.gpl3;
    maintainers = [myamusashi];
  };
}
