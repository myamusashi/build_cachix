{
  lib,
  formats,
  stdenvNoCC,
  fetchFromGitLab,
  libsForQt5,
  themeConfig ? {},
}: let
  user-cfg = (formats.ini {}).generate "theme.conf.user" themeConfig;
in
  stdenvNoCC.mkDerivation {
    pname = "reactionary";
    version = "e80331c3";

    src = fetchFromGitLab {
      domain = "www.opencode.net";
      owner = "phob1an";
      repo = "reactionary";
      rev = "master";
      sha256 = "sha256-obKYi85SEMSvoF9KY8TbU02mag57yr/03TvNNNa67N0=";
    };

    propagatedBuildInputs = [
      libsForQt5.qt5.qtgraphicaleffects
    ];

    dontWrapQtApps = true;

    installPhase =
      ''
        runHook preInstall

        mkdir -p $out/share/sddm/themes/reactionary
        cp -r sddm/themes/reactionary/* $out/share/sddm/themes/reactionary/
      ''
      + (lib.optionalString (lib.isAttrs themeConfig) ''
        ln -sf ${user-cfg} $out/share/sddm/themes/reactionary/theme.conf.user
      '')
      + ''
        runHook postInstall
      '';

    meta = with lib; {
      license = licenses.gpl3;
      maintainers = with lib.maintainers; [myamusashi];
      homepage = "https://www.opencode.net/phob1an/reactionary";
      description = "Reactionary Look-and-Feel";
      longDescription = "Just a bit of fun recreating the look and feel of ReactOS";
    };
  }
