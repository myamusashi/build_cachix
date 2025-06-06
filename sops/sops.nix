{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "/home/waltz/.config/sops/age/keys.txt";

    defaultSopsFile = ./secrets.json;
    defaultSopsFormat = "json";

    secrets.cloudflare_creds = {
      format = "json";
      mode = "0400";
    };

    secrets.nix-serve_secrets = {
      format = "json";
      mode = "0400";
    };

    secrets.nextcloud_admin_pass = {
      format = "json";
      mode = "0400";
    };
  };
}
