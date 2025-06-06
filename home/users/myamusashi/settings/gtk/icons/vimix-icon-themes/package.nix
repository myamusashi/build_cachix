{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gitUpdater,
  gtk3,
  hicolor-icon-theme,
  colorVariants ? [], # default: all
}: let
  pname = "vimix-icon-theme";
in
  lib.checkListOfEnum "${pname}: color variants"
  [
    "standard"
    "Amethyst"
    "Beryl"
    "Doder"
    "Ruby"
    "Jade"
    "Black"
    "White"
  ]
  colorVariants
  stdenvNoCC.mkDerivation
  rec {
    inherit pname;
    version = "2023-06-26";

    src = fetchFromGitHub {
      owner = "vinceliuice";
      repo = pname;
      rev = version;
      sha256 = "5pTYsWdmjSDyrEK+Jbg/9dQ1FHI2rdnr1n0Ysd5mg/U=";
    };

    nativeBuildInputs = [
      gtk3
    ];

    propagatedBuildInputs = [
      hicolor-icon-theme
    ];

    dontDropIconThemeCache = true;

    dontCheckForBrokenSymlinks = true;

    postPatch = ''
      patchShebangs install.sh
    '';

    installPhase = ''
      runHook preInstall

      ./install.sh \
        ${
        if colorVariants != []
        then builtins.toString colorVariants
        else "-a"
      } \
        -d $out/share/icons

      runHook postInstall
    '';

    passthru.updateScript = gitUpdater {};

    meta = with lib; {
      description = "Material Design icon theme based on Paper icon theme";
      homepage = "https://github.com/vinceliuice/vimix-icon-theme";
      license = with licenses; [cc-by-sa-40];
      platforms = platforms.linux;
      maintainers = with maintainers; [romildo];
    };
  }
