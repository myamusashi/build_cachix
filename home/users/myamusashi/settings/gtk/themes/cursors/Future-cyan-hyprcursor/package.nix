{
  stdenvNoCC,
  fetchFromGitLab,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "Future-Cyan-Hyprcursor-theme";
  version = "main";

  src = fetchFromGitLab {
    owner = "Pummelfisch";
    repo = "future-cyan-hyprcursor";
    rev = "${version}";
    sha256 = "sha256-Pi8+efEohVfH1iJ3oLcWLQuAOAZfR4iUOPmo4oyvrLE=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/Future-Cyan-Hyprcursor_Theme
    cp -r Future-Cyan-Hyprcursor_Theme/* $out/share/icons/Future-Cyan-Hyprcursor_Theme
  '';

  meta = with lib; {
    description = "A futuristic hyprcursor theme.";
    homepage = "https://gitlab.com/Pummelfisch/future-cyan-hyprcursor";
    license = lib.licenses.gpl3;
    maintainers = with maintainers; [myamusashi];
  };
}
