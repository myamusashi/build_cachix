{
  fileSystems = {
    "/run/media/apalah" = {
      device = "/dev/disk/by-uuid/769AF2A09AF25BD5";
      fsType = "ntfs-3g";
      options = [
        "defaults"
        "uid=1000"
        "gid=1000"
        "nodev"
        "permissions"
      ];
      noCheck = true;
    };
  };

  zramSwap = {
    enable = true;
    priority = 1;
    algorithm = "zstd";
    memoryPercent = 50;
    memoryMax = null;
  };
}
