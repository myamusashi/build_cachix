{
  pkgs,
  pkgs-stable,
  inputs,
  ...
}: let
  qtfm = pkgs.callPackage ./extra/qtfm.nix {};
  reactionary = pkgs.callPackage ./extra/reactionary.nix {};
in {
  environment.systemPackages = with pkgs; [
    qtfm
    reactionary
    inputs.kwin-effects-forceblur.packages.${system}.default
    pass-wayland
    passExtensions.pass-import
    home-manager
    vim
    lftp
    zed-editor-fhs
    poppler_utils
    libreoffice
    proton-pass
    vulkan-tools
    libgdiplus
    winetricks
    polkit
    ciscoPacketTracer8
    tree-sitter
    proton-ge-custom
    libgcc
    libGL
    libGLU
    pciutils
    blesh
    gnome-keyring
    onlyoffice-desktopeditors
    ffmpeg
    pcsx2
    apacheHttpd
    nemo-with-extensions
    vulkan-tools
    virt-v2v
    (linuxKernel.packages.linux_zen.vmware.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "philipl";
        repo = "vmware-host-modules";
        rev = "93d8bf38d7e705a862dcbfa721884638a817d476";
        hash = "sha256-i2E3QAy5P3U+EqSaFaCQGuiU4vt/yYKv3oJBP1qK9Og=";
      };

      patches = [
        (fetchpatch {
          url = "https://github.com/amadejkastelic/vmware-host-modules/commit/926cfc50c017a099c796662c8e2820d12f94d0bb.patch";
          hash = "sha256-9XLhypr77Qy9Ty54Pm48DYYh3HT1WAmiwGOmBk3AfyI=";
        })
      ];
    }))
    (
      pkgs-stable.vmware-workstation.overrideAttrs (e: {
        installPhase = ''
          ${e.installPhase}
          mv $out/bin/vmware $out/bin/vmware-bin
          makeWrapper $out/bin/vmware-bin $out/bin/vmware \
            --set GTK_THEME "Adwaita-dark"
          if [ -f $out/share/applications/vmware-workstation.desktop ]; then
            substituteInPlace $out/share/applications/vmware-workstation.desktop \
              --replace "Exec=@@BINARY@@" "Exec=$out/bin/vmware"
          fi
        '';

        nativeBuildInputs = (e.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
      })
    )
    kdePackages.sddm-kcm
    cloudflare-warp
    udiskie
    udisks
    wineWowPackages.waylandFull
    winetricks
    carlito
    jflap
    netbeans
    gparted
    linux-wifi-hotspot
    dynamips
    wireshark
    ubridge
    busybox
    inetutils
    libvirt
    python3
    upower
    upower-notify
    virt-viewer
    alejandra
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    kdePackages.ksystemlog
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    kdePackages.dolphin
    kdePackages.kate
    hardinfo2
    kdiff3
  ];
}
