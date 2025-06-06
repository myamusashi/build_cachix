{
  programs.dconf.enable = true;
  imports = [
    ./steam/steam.nix
    ./wireshark/wireshark.nix
    # ./honkers/honkers.nix
    ./xonsh/xonsh.nix
  ];
}
