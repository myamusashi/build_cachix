{pkgs-stable, ...}: {
  systemd.services.cachix_runner = {
    description = "Cachix daemon";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs-stable.cachix}/bin/cachix daemon run myamusashi";
      Restart = "always";
      RestartSec = 15;
    };
  };
}
