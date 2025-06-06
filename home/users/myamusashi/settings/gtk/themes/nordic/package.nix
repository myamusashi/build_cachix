{
  stdenv,
  fetchFromGitHub,
  lib,
  theme,
}:
stdenv.mkDerivation rec {
  pname = "Nordic";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = pname;
    rev = "v${version}";
    sha256 = "1z5s5rsgiypanf2z0avaisbflnvwrc8aiy5qskrsvbbaja63jy3s";
  };

  installPhase = ''
    mkdir -p $out/share/themes
    cp -r . $out/share/themes/Nordic
  '';

  meta = with lib; {
    description = "Nordic GTK theme";
    homepage = "https://github.com/EliverLara/Nordic";
    license = licenses.gpl3Only;
    maintainers = [maintainers.myamusashi];
  };
}
