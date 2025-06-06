{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.verbose = false;
    consoleLogLevel = 0;
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "cross_hud";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["cross_hud"];
        })
      ];
    };

    supportedFilesystems = ["ntfs"];
    kernelModules = [
      "kvm-intel"
      "uas"
      "usbhid"
      "hid"
      "usb_storage"
      "zram"
    ];
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "boot.shell_on_fail"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "console=tty1"
      "noibrs"
      "noibpb"
      "nopti"
      "nospectre_v2"
      "nospectre_v1"
      "l1tf=off"
      "nospec_store_bypass_disable"
      "no_stf_barrier"
      "mds=off"
      "mitigations=off"
    ];

    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;
      "net.core.somaxconn" = 1024;
      "net.core.netdev_max_backlog" = 5000;

      "net.ipv4.tcp_rmem" = "4096 87380 16777216";
      "net.ipv4.tcp_wmem" = "4096 87380 16777216";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_fastopen" = 3;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_mtu_probing" = 1;
      "net.ipv4.tcp_window_scaling" = 1;
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.ipv4.tcp_keepalive_intvl" = 10;
      "net.ipv4.tcp_keepalive_probes" = 6;

      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.swappiness" = 15;
    };
  };
}
