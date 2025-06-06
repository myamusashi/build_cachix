{pkgs-stable, ...}: {
  systemd.services.stirling-pdf = {
    description = "Stirling-PDF service";
    after = ["syslog.target" "network.target"];
    wantedBy = ["multi-user.target"];
    environment = {
      SYSTEM_DEFAULTLOCALE = "en-US";
    };

    serviceConfig = {
      SuccessExitStatus = 143;
      WorkingDirectory = "/opt/Stirling-PDF";

      ExecStart = "${pkgs-stable.jdk}/bin/java -jar stirling-pdf.jar";
      ExecStop = "${pkgs-stable.coreutils}/bin/kill -15 $MAINPID";

      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}
