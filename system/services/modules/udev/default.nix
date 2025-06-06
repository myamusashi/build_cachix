{
  services.udev.enable = true;
  services.udev.extraRules = builtins.concatStringsSep "\n" (map builtins.readFile [
    ./rules/battery-low.rules
    ./rules/bt-connected.rules
    ./rules/charged-battery-connected.rules
    ./rules/wireshark-group.rules
  ]);
}
