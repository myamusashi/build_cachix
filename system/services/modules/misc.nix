{pkgs, ...}: {
  services = {
    cloudflare-warp.enable = true;
    xserver.videoDrivers = ["vmware"];
    gnome.gnome-keyring.enable = true;
    scx.enable = true;
    fwupd.enable = true;
    throttled.enable = true;

    printing.enable = false;
    udisks2.enable = true;

    gvfs.enable = false;

    flatpak.enable = false;

    blueman.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    openssh.enable = true;

    locate.package = pkgs.mlocate;
    locate.enable = true;

    earlyoom = {
      enable = true;
      enableNotifications = true;
      freeMemKillThreshold = 2;
      freeSwapKillThreshold = 3;
    };

    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    tlp = {
      enable = false;
      settings = {
        ## CPU
        INTEL_GPU_MIN_FREQ_ON_AC = 300;
        INTEL_GPU_MIN_FREQ_ON_BAT = 300;

        INTEL_GPU_MAX_FREQ_ON_AC = 999999999;
        INTEL_GPU_MAX_FREQ_ON_BAT = 999999999;

        INTEL_GPU_BOOST_FREQ_ON_AC = 0;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 0;

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        ## Battery
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;

        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 80;

        TPSMAPI_ENABLE = 1;

        ## Kernel
        NMI_WATCHDOG = 0;
      };
    };
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };

  systemd.services."getty@tty2".enable = false;
}
