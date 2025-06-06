{pkgs, ...}: {
  services.greetd = {
    enable = false;
    vt = 2;
    settings = {
      initial_session = {
        command = "Hyprland";
        user = "myamusashi";
      };
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet tuigreet --remember --remember-user-session --time --asterisks --asterisks-char "+" --greeting "Loh kok bisa"  --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red --cmd ${pkgs.sway}/bin/sway'';
        user = "greeter";
      };
    };
  };
}
