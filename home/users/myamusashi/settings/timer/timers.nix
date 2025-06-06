{
  systemd.user.startServices = true;

  imports = [
    ./modules/get_current_wallpaper/default.nix
    ./modules/adzan/default.nix
    ./modules/get_adzan_data/default.nix
  ];
}
