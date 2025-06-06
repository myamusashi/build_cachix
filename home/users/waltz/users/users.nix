{pkgs-stable, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.waltz = {
    isNormalUser = true;
    description = "gilang";
    shell = pkgs-stable.fish;
    extraGroups = ["networkmanager" "wheel" "vsftpd" "docker"];
  };

  users.groups.cloudflared = {};
  users.users.cloudflared = {
    isSystemUser = true;
    group = "cloudflared";
    description = "Cloudflare Tunnel service user";
    extraGroups = ["forgejo"];
  };

  users.groups.nextcloud = {};
  users.users.nextcloud = {
    isSystemUser = true;
    group = "nextcloud";
  };

  users.groups.atticd = {};
  users.users.atticd = {
    isSystemUser = true;
    group = "atticd";
  };

  users.groups.forgejo-runner = {};
  users.users.forgejo-runner = {
    isNormalUser = true;
    group = "forgejo-runner";
    extraGroups = ["forgejo" "docker"];
  };
}
