{
  fetchFromGitHub,
  stdenv,
  lib,
  libnotify,
  libsForQt5,
  udisks,
  imagemagick,
  desktop-file-utils,
  hicolor-icon-theme,
  adwaita-icon-theme,
}:
stdenv.mkDerivation rec {
  pname = "qtfm";
  version = "44a55eb";

  src = fetchFromGitHub {
    owner = "rodlie";
    repo = pname;
    rev = "44a55eba97ef6c3eef0cd2277774354cb1739f84";
    hash = "sha256-N9ywdYupRhTvirmNR6kfTGjqgi8yENxqCnsykQzQy9c=";
  };

  nativeBuildInputs = [
    libsForQt5.qmake
    libsForQt5.qt5.wrapQtAppsHook
    desktop-file-utils
  ];

  propagatedBuildInputs = [
    libsForQt5.qt5.qtbase
    libnotify
    udisks
    imagemagick
    hicolor-icon-theme
    adwaita-icon-theme
  ];

  outputs = [
    "out"
    "dev"
  ];

  postPatch = ''
    find . -name "*.pro" -exec sed -i 's|/etc/xdg|$$PREFIX/etc/xdg|g' {} \;

    find . -name "*.pro" -exec sed -i '/desktop.path.*etc\/xdg/d' {} \;
    find . -name "*.pro" -exec sed -i '/INSTALLS.*desktop/d' {} \;
  '';

  qmakeFlags = [
    "CONFIG+=release"
    "PREFIX=${placeholder "out"}"
  ];

  installPhase = ''
    runHook preInstall

    # Install binaries
    mkdir -p $out/bin
    cp bin/qtfm $out/bin/
    cp bin/qtfm-tray $out/bin/

    mkdir -p $out/share/applications
    cp fm/qtfm.desktop $out/share/applications/

    mkdir -p $out/share/icons
    cp -r share/hicolor $out/share/icons/

    mkdir -p $out/share/man/man1
    cp fm/qtfm.1 $out/share/man/man1/
    cp tray/qtfm-tray.1 $out/share/man/man1/

    mkdir -p $out/share/doc/${pname}-${version}
    cp LICENSE README.md AUTHORS ChangeLog $out/share/doc/${pname}-${version}/

    runHook postInstall
  '';

  meta = with lib; {
    description = "Qt File Manager";
    homepage = "https://github.com/rodlie/qtfm";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [myamusashi];
    platforms = platforms.linux ++ platforms.freebsd;
  };
}
