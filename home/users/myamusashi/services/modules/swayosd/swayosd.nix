{pkgs, ...}: let
  path = "/home/myamusashi/.dots/home/users/myamusashi/services/modules/swayosd/styles.css";
in {
  services.swayosd = {
    enable = true;
    package = pkgs.swayosd;
    display = ""; ## Means auto
    topMargin = 0.3;
    stylePath = path;
  };
}
