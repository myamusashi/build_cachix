{pkgs, ...}: {
  systemd.user.timers.adzan = {
    Unit = {Description = "Timer adzan harian";};
    Timer = {
      OnCalendar = "*:*:00";
      Persistent = true;
      Unit = "adzan";
    };
    Install = {WantedBy = ["timers.target"];};
  };

  systemd.user.services.adzan = {
    Unit = {Description = "Service notify adzan harian";};
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "adzan-notify" ''
        ${pkgs.bash}/bin/bash $HOME/.dots/scripts/adzan_notify.sh
      ''}";
    };
  };
}
