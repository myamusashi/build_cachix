{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-25.05";
    sops-nix.url = "github:Mic92/sops-nix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:myamusashi/zen-twilight-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };

    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprsunset = {
      url = "github:hyprwm/hyprsunset";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = {
    nixpkgs,
    nixpkgs-stable,
    chaotic,
    nixgl,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.hyprpanel.overlay
        inputs.hyprpicker.overlays.default
        inputs.hyprsunset.overlays.default
        inputs.hypridle.overlays.default
        inputs.hyprland.overlays.default
        nixgl.overlay
        inputs.neovim-nightly-overlay.overlays.default
        (import ./overlays/default.nix)
      ];
    };
  in {
    nixosConfigurations = {
      waltz = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./home/users/waltz/default.nix
          ./home/common/programs/htop.nix
          ./home/common/programs/lazygit.nix
          ./home/common/services.nix
          ./home/common/packages.nix
          ./home/common/nixConfig.nix
          ./sops/sops.nix
          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry
        ];
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
        };
      };

      # NOTE: nixos dan myamusashi sama saja
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          chaotic.nixosModules.default
          ./system/default.nix
          ./home/common/programs/htop.nix
          ./home/common/programs/lazygit.nix
          ./home/common/services.nix
          ./home/common/packages.nix
          ./home/common/nixConfig.nix
        ];
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
        };
      };
    };

    homeConfigurations = {
      "myamusashi" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit system;
          inherit inputs;
        };

        modules = [
          ./home/common/programs/git.nix
          ./home/users/myamusashi/default.nix
          ./scripts/symlinks/symlinks.nix
          ./home/common/nixConfig.nix
        ];
      };
    };
  };
}
