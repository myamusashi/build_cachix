{pkgs, ...}: {
  programs.fish.enable = true;

  users.users.myamusashi = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel" "mlocate" "gns3" "docker" "libvirtd" "wireshark" "ubridge" "video" "input" "wireshark"];
  };

  users.groups.ubridge = {};
}
