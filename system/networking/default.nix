{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      settings = {
        device.managed = true;
      };
    };
    nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    extraHosts = ''
      127.0.0.1 goblok.com
    '';
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        554
        460
      ];
      allowedUDPPorts = [
        22
        556
      ];
    };
  };
}
