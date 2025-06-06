{
  inputs,
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.brightnessctl
    pkgs.wl-clipboard
    pkgs.wayland-protocols
    pkgs.rich-cli
    pkgs.gh
    pkgs.cloudflared
    pkgs.mysql-workbench
    pkgs.attic-client
    pkgs.git-credential-manager
    pkgs.wl-gammactl
    pkgs.yazi
    pkgs.rofi-wayland
    pkgs.grim
    pkgs.slurp
    pkgs.hyprshot
    pkgs.ffmpegthumbnailer
    pkgs.swww
    pkgs.playerctl
    pkgs.pavucontrol
    pkgs.libnotify
    pkgs.hyprpanel
    pkgs.viewnior
    pkgs.mpg123
    pkgs.zathura
    pkgs.postman
    pkgs.kdePackages.qt6ct
    pkgs.libsForQt5.qt5ct
    (config.lib.nixGL.wrap inputs.zen-browser.packages.${pkgs.system}.default)
    pkgs.wf-recorder
    pkgs.waypaper
    pkgs.power-profiles-daemon
    pkgs.hyprsunset
    pkgs.vesktop
    pkgs.hyprpicker
    pkgs.telegram-desktop
    # inputs.quickshell.packages.${pkgs.system}.default
  ];
}
