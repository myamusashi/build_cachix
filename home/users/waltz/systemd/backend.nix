{pkgs, ...}: {
  systemd.services.nix-build-monitor-backend = {
    description = "Nix Build Monitor Backend API";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    path = with pkgs; [
      bash
      coreutils
      procps
      nodejs_22
      findutils
      gnugrep
      gawk
      gnused
    ];
    serviceConfig = {
      Type = "simple";
      WorkingDirectory = "/var/www/nix-cache-backend";
      ExecStart = "${pkgs.nodejs_22}/bin/node ./dist/index.js";
      Environment = [
        "PORT=3000"
      ];
      Restart = "on-failure";
    };
  };
}
