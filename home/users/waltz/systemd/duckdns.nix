{pkgs-stable, ...}: {
  systemd.timers.duckdns = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "*:0/5"; # Runs every 5 minutes
      Persistent = true;
    };
  };

  systemd.services.duckdns = {
    description = "Duck DNS configuration";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs-stable.writeShellScript "duck.sh" ''
        ${pkgs-stable.bash}/bin/bash /home/waltz/scripts/duck.sh
      ''}";
    };
  };
}
