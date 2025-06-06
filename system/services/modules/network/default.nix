{
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    extraConfig = ''
      DNSStubListener=yes
      Cache=yes
      DNSStubListenerExtra=127.0.0.1
    '';
  };

  # Enable hostpot
  services.create_ap = {
    enable = false;
    settings = {
      INTERNET_IFACE = "enp0s31f6";
      WIFI_IFACE = "wlp3s0";
      SSID = "nixos";
      PASSPHRASE = "12345678";
    };
  };
}
