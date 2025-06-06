{
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.openssh = {
    enable = true;
    settings = {
      PubkeyAuthentication = true;
      TrustedUserCAKeys = "/etc/ssh/ca.pub";
    };
  };
}
