{
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    21
    22
    25
    80
    110
    143
    443
    465
    587
    9000
    6379
    5432
    995
    26379
    6379
    5432
    993
    990 # ftps
    989 # ftps
    3000 # forgejo
    5500 # nix-serve
    4040 # Attic
    8090
  ];
  networking.firewall.allowedUDPPorts = [
  ];

  networking.extraHosts = ''
    192.168.18.14 myamusashi.com
    127.0.0.1 mail.myamusashi.com
    127.0.0.1 cache.myamusashi.com
    127.0.0.1 cloud.myamusashi.com
    127.0.0.1 myamusashi.com
    127.0.0.1 pma.myamusashi.com
  '';
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
}
