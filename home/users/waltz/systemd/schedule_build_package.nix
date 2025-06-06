{
  lib,
  pkgs,
  ...
}: {
  # Definisikan direktori kerja untuk operasi flake
  # Ini penting karena nix flake update harus dijalankan di dalam direktori flake
  # Jika `/etc/nixos` bukan direktori flake, sesuaikan ini.
  # Asumsi bahwa flake Anda adalah `/etc/nixos`.

  # 1. Service Utama untuk menjalankan semua langkah secara berurutan
  systemd.services.nixos-maintenance-and-build = let
    flakeDir = "/etc/nixos";
  in {
    description = "NixOS Monthly Maintenance and Build";
    wantedBy = ["multi-user.target"];
    path = with pkgs; [nix nixos-rebuild home-manager git]; # Pastikan semua tools yang dibutuhkan ada di PATH
    serviceConfig = {
      Type = "oneshot";
      # Gunakan 'bash -c' untuk menjalankan beberapa perintah secara berurutan
      ExecStart = "${pkgs.writeShellScript "build_update" ''
        ${pkgs.nixos-rebuild}/bin/nixos-rebuild build --keep-going --flake path:${flakeDir}#waltz
        ${pkgs.nixos-rebuild}/bin/nixos-rebuild build --keep-going --flake path:${flakeDir}#nixos

        # Jalankan Home Manager build
        # Pastikan user 'myamusashi' ada dan direktori HOME-nya benar
        # Jika Anda menjalankan ini sebagai root, pastikan home-manager dapat menemukan konfigurasi user tersebut.
        HOME=/home/myamusashi ${pkgs.home-manager}/bin/home-manager build --keep-going --flake path:${flakeDir}#myamusashi
      ''}";
      User = "root"; # Jalankan sebagai root untuk hak akses yang diperlukan
    };
  };

  # Timer untuk menjalankan service utama setiap bulan
  systemd.timers.nixos-maintenance-and-build = {
    description = "Monthly NixOS Maintenance and Build Timer";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "monthly"; # Jalankan setiap bulan
      Persistent = true; # Jika mesin mati, akan dijalankan saat boot berikutnya
      Unit = "nixos-maintenance-and-build.service"; # Memicu service utama
    };
  };

  # Hapus service dan timer terpisah yang lama agar tidak ada duplikasi
  # lib.mkDefault akan memastikan ini di-override jika ada definisi lain
  systemd.services.nix-gc = lib.mkDefault {enable = false;};
  systemd.timers.nix-gc = lib.mkDefault {enable = false;};

  systemd.services.nixos-build-waltz = lib.mkDefault {enable = false;};
  systemd.timers.nixos-build-waltz = lib.mkDefault {enable = false;};

  systemd.services.nixos-build-nixos = lib.mkDefault {enable = false;};
  systemd.timers.nixos-build-nixos = lib.mkDefault {enable = false;};

  systemd.services.home-manager-build-myamusashi = lib.mkDefault {enable = false;};
  systemd.timers.home-manager-build-myamusashi = lib.mkDefault {enable = false;};
}
