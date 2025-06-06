{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation rec {
  pname = "Future-cursors";
  version = "master";

  src = fetchFromGitHub {
    owner = "yeyushengfan258";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "sha256-ziEgMasNVhfzqeURjYJK1l5BeIHk8GK6C4ONHQR7FyY=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/${pname}
    cp -pr dist/* $out/share/icons/${pname}
  '';

  meta = with lib; {
    description = "Future cursors for linux desktops";
    homepage = "https://github.com/yeyushengfan258/Future-cursors";
    license = licenses.gpl3;
    maintainers = with maintainers; [myamusashi];
  };
}
