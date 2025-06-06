{pkgs, ...}: {
  systemd.user.timers.getWP = {
    Unit = {Description = "Timer dapet wallpaper untuk hyprlock";};
    Timer = {
      OnCalendar = "*:*:00";
      Persistent = true;
      Unit = "getWP";
    };
    Install = {WantedBy = ["timers.target"];};
  };

  systemd.user.services.getWP = {
    Unit = {Description = "Services dapet current desktop screenshot";};
    serviceConfig = {
      path = [
        "${pkgs.gawk}/bin"
        "${pkgs.swww}/bin"
        "${pkgs.hyprshot}/bin"
        "${pkgs.grim}/bin"
      ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "getWP" ''
        ${pkgs.bash}/bin/bash $HOME/.dots/scripts/cache_wall.sh
      ''}";
    };
  };
}
