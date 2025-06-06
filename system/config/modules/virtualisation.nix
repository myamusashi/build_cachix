{
  config,
  pkgs-stable,
  pkgs,
  ...
}: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        intel-vaapi-driver
      ];
    };
  };

  chaotic.mesa-git.enable = true;

  virtualisation = {
    docker.enable = false;
    libvirtd.enable = true;
    podman = {
      enable = false;
      dockerCompat = true;
      defaultNetwork.settings = {dns_enabled = true;};
    };
    vmware = {
      host.enable = true;
      # host.package = pkgs-stable.vmware-workstation;
      guest = {
        enable = true;
        package = pkgs.open-vm-tools;
      };
    };
  };
}
