{
  imports = [
    ./config/config.nix
    ./services/services.nix
    ./users/users.nix
    ./network/network.nix
    ./packages/packages.nix
    ./boot/boot.nix
    ./programs/programs.nix
    ./security/security.nix
    ./virtualisation/virtualisation.nix
    ./systemd/stirling-pdf.nix
    ./systemd/forgejo_runner.nix
    ./systemd/cloudflare_tunnel.nix
    # ./systemd/schedule_build_package.nix
  ];
}
