{
  stdenvNoCC,
  fetchurl,
  configFile,
}:
stdenvNoCC.mkDerivation rec {
  name = "phpmyadmin-${version}";
  version = "5.2.2";

  src = fetchurl {
    url = "https://files.phpmyadmin.net/phpMyAdmin/${version}/phpMyAdmin-${version}-all-languages.tar.gz";
    sha256 = "sha256-hVHIvzsWbyMtXPZLrId0cunQy48v4YWPqyT5defXZbY=";
  };

  phases = [
    "unpackPhase"
    "installPhase"
  ];

  installPhase = ''
    mkdir -p $out
    cp -r * $out/
    ln -s ${configFile} $out/config.inc.php
  '';

  meta = {
    homepage = "https://www.phpmyadmin.net/";
    description = "phpMyAdmin is a free and open source administration tool for MySQL and MariaDB";
  };
}
