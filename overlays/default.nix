final: prev: {
  upower = prev.upower.overrideAttrs (oldAttrs: {
    doCheck = false;
  });

  # kitty = prev.kitty.overrideAttrs (oldAttrs: {
  #   patches =
  #     (oldAttrs.patches or [])
  #     ++ [
  #       ./patch/kitty-patch/fix_wl_platform_toplevel.patch
  #       ./patch/kitty-patch/fix_xdg_toplevel_switch.patch
  #     ];
  # });

  vmware-workstation = prev.vmware-workstation.overrideAttrs (oldAttrs: let
    version = "17.6.1";
    build = "24319023";
    baseUrl = "https://web.archive.org/web/20241105192443if_/https://softwareupdate.vmware.com/cds/vmw-desktop/ws/${version}/${build}/linux";
    vmware-unpack-env = prev.buildFHSEnv {
      pname = "vmware-unpack-env";
      inherit version;
      targetPkgs = pkgs: [pkgs.zlib];
    };
  in {
    src =
      prev.fetchzip {
        url = "${baseUrl}/core/VMware-Workstation-${version}-${build}.x86_64.bundle.tar";
        hash = "sha256-VzfiIawBDz0f1w3eynivW41Pn4SqvYf/8o9q14hln4s=";
        stripRoot = false;
      }
      + "/VMware-Workstation-${version}-${build}.x86_64.bundle";
    installPhase = ''
      ${oldAttrs.installPhase}

      mv $out/bin/vmware $out/bin/vmware-bin
      makeWrapper $out/bin/vmware-bin $out/bin/vmware \
        --set GTK_THEME "Adwaita-dark"

      if [ -f $out/share/applications/vmware-workstation.desktop ]; then
        substituteInPlace $out/share/applications/vmware-workstation.desktop \
          --replace "Exec=@@BINARY@@" "Exec=$out/bin/vmware"

        substituteInPlace $out/share/applications/vmware-player.desktop \
          --replace "Exec=@@BINARY@@" "Exec=$out/bin/vmware"
      fi
    '';

    # Make sure makeWrapper is available
    # nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [pkgs.makeWrapper];

    unpackPhase = ''
      ${vmware-unpack-env}/bin/vmware-unpack-env -c "sh ${final.vmware-workstation.src} --extract unpacked"
    '';
  });
}
