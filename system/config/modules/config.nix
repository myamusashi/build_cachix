{
  pkgs,
  nixgl,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  # Nuh uh, don't fucking changing it
  system.stateVersion = "24.11"; # Did you read the comment?

  fonts.fontDir.enable = true;

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    hyprland.enable = true;
    ccache.enable = true;
    java.enable = true;
    java.package = pkgs.jdk23;
  };
}
