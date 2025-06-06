{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "CaskaydiaMono Nerd Font:size=10";
        font-size-adjustment = 0.7;
        box-drawings-uses-font-glyphs = true;
        dpi-aware = true;
        workers = 1;
      };

      cursor = {
        style = "beam";
        beam-thickness = 1;
      };

      colors = {
        foreground = "DCD7BA";
        background = "16161D";
        regular0 = "1E1F28"; #black
        regular1 = "E82424"; #red
        regular2 = "98BB6C"; #green
        regular3 = "E6C384"; #yellow
        regular4 = "7E9CD8"; #blue
        regular5 = "957FB8"; #magenta
        regular6 = "9CABCA"; #cyan
        regular7 = "DAD5B8"; #white
      };

      mouse = {
        hide-when-typing = true;
      };
    };
  };
}
