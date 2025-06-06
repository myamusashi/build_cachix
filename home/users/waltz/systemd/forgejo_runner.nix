{pkgs-stable, ...}: {
  systemd.services.forgejo-runner = {
    description = "Forgejo Actions Runner";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = "/etc/forgejo-runner";
      ExecStart = "${pkgs-stable.forgejo-runner}/bin/act_runner daemon";
      Restart = "always";
      RestartSec = 15;
    };
  };
}
