{
  pkgs,
  config,
  ...
}: {
  systemd.tmpfiles.rules = [
    "d /var/lib/cloudflared 0750 root root - -"
  ];

  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel Service";
    after = [
      "network-online.target"
      "forgejo.service"
      "nextcloud-setup.service"
      "sshd.service"
      "stirling-pdf.service"
      "forgejo.service"
      "nix-serve.service"
    ];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "5";
      NoNewPrivileges = true;
      PrivateTmp = true;
      ReadWritePaths = [
        "/var/lib/cloudflared"
        "/run/forgejo"
      ];

      RestrictAddressFamilies = ["AF_INET" "AF_INET6" "AF_UNIX"];

      PrivateNetwork = false;
      PrivateNamespaces = false;
      RestrictNamespaces = false;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallArchitectures = "native";

      SystemCallFilter = [
        "@system-service"
        "@network-io"
        "socket"
        "connect"
        "bind"
      ];

      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /var/lib/cloudflared";
      ExecStart = "/bin/sh -c '${pkgs.cloudflared}/bin/cloudflared tunnel run --token $(${pkgs.coreutils}/bin/cat ${config.sops.secrets.cloudflare_creds.path})'";

      LoadCredential = [
        "cloudflare_creds:${config.sops.secrets.cloudflare_creds.path}"
      ];
    };
  };
}
