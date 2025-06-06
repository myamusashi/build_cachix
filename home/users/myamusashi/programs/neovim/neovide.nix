{
  pkgs,
  config,
  ...
}: {
  programs.neovide = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.neovide;
    settings = {
      vsync = false;
      srgb = true;
      neovim-bin = "nvim";
    };
  };
}
