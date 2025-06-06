{
  services.hypridle = {
    enable = false;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        unlock_cmd = "notify-send 'woilah cik!'";
      };

      listener = [
        {
          timeout = 200;
          on-timeout = "wl-gammactl -c 0.5";
          on-resume = "pkill wl-gammactl";
        }

        {
          timeout = 1500;
          on-timeout = "pkill wl-gammactl && wl-gammactl -c 0.1";
          on-resume = "pkill wl-gammactl";
        }

        {
          timeout = 1800;
          on-timeout = "notify-send -a 'Hypridle' 'Idle' 'Bangun woy, gua kunci nih' -i $HOME/.dots/scripts/image/2025-03-01_08-03-1740792858.png";
        }

        {
          timeout = 2000;
          on-timeout = "bash $HOME/.dots/scripts/check_compile_running.sh"; # sleep with different powerprofiles
          on-resume = "powerprofilesctl set performance";
        }
      ];
    };
  };
}
