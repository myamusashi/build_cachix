{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
      };
      colors = {
        background = "171717ff";
        text = "dcd7baff";
        border = "e6c384ff";
        match = "363646ff";
        selection = "54546dff";
        selection-match = "2a2a37ff";
        selection-text = "938aa9ff";
      };
    };
  };
}
