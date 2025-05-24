{
  description = "Build packages";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system} = {
      webkitgtk = pkgs.callPackage ./webkitgtk {
        gst-plugins-bad = pkgs.gst_all_1.gst-plugins-bad;
      };
      hyprspace = pkgs.callPackage ./hyprspace {};
      telegram-desktop = pkgs.callPackage ./telegram-desktop {};
      vesktop = pkgs.callPackage ./vesktop {};
      default = pkgs.symlinkJoin {
        name = "all-packages";
        paths = [
          self.packages.${system}.webkitgtk
          self.packages.${system}.hyprspace
          self.packages.${system}.telegram-desktop
          self.packages.${system}.vesktop
        ];
      };
    };
  };
}
