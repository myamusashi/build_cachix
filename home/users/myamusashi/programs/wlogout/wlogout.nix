let
  path = "$HOME/.dots/home/users/myamusashi/programs/wlogout/confirm.sh";
in {
  programs.wlogout = {
    enable = true;
    style = ./style.css;
    layout = [
      {
        label = "shutdown";
        action = "bash ${path} shutdown";
        text = "Mati";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "bash ${path} reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "sleep";
        action = "bash ${path} suspend";
        text = "Turu";
        keybind = "t";
      }
      {
        label = "hibernate";
        action = "bash ${path} hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "lock";
        action = "bash ${path} lock";
        text = "konci";
        keybind = "l";
      }
      {
        label = "logout";
        action = "bash ${path} logout";
        text = "keluar";
        keybind = "e";
      }
    ];
  };
}
