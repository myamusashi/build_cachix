{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    theme = "reactionary";
    extraPackages = with pkgs; [
      kdePackages.sddm-kcm
    ];
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
}
