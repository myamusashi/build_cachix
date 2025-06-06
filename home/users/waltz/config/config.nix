{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.trusted-users = ["root" "waltz"];

  nixpkgs.overlays = [
    (self: super: {
      tree-sitter-bundled-vendor = super.tree-sitter-bundled-vendor.overrideAttrs (oldAttrs: {
        # Update hash untuk vendor bundle
        vendorHash = "sha256-ie+/48dVU3r+tx/sQBWRIZEWSNWwMBANCqQLnv96JXs=";
      });
    })
  ];

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
