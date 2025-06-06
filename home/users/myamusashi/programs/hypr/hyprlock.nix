{
  pkgs,
  inputs,
  ...
}: let
  kanagawaColors = import ./colors/kanagawa.nix;
  mochaColors = import ./colors/mocha.nix;

  fontFamily = "ProggyClean Nerd Font";
  accentAlpha = "${mochaColors.mauveAlpha}";
in {
  programs.hyprlock = {
    enable = true;
    package = pkgs.hyprlock;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = false;
        ignore_empty_input = true;
      };
    };
  };
  programs.hyprlock.extraConfig = ''
    background {
      blur_passes = 1
      blur_size = 5
      monitor = eDP-1
      path = $HOME/.cache/wall/eDP.png
      color = ${kanagawaColors.background}
    }

    background {
      blur_passes = 1
      blur_size = 2
      monitor = HDMI-A-2
      path = $HOME/.cache/wall/HDMI.png
      color = ${kanagawaColors.background}
    }

    # TIME
    label {
      monitor = eDP-1
      text = cmd[update:30000] echo "$(date +'%R')"
      color = ${kanagawaColors.color1}
      font_size = 70
      font_family = ${fontFamily}
      position = 0, 50
      halign = center
      valign = center
    }

    label {
      monitor = HDMI-A-2
      text = cmd[update:30000] echo "$(date +'%R')"
      color = ${kanagawaColors.color1}
      font_size = 70
      font_family = ${fontFamily}
      position = 0, -10
      halign = center
      valign = center
    }

    # DATE
    label {
      monitor = eDP-1
      text = cmd[update:43200000] echo "$(date +'%A, %d %B %Y')"
      color = ${kanagawaColors.color1}
      font_size = 25
      font_family = ${fontFamily}
      position = 0, -10
      halign = center
      valign = center
    }

    label {
      monitor = HDMI-A-2
      text = cmd[update:43200000] echo "$(date +'%A, %d %B %Y')"
      color = ${kanagawaColors.color1}
      font_size = 25
      font_family = ${fontFamily}
      position = 0, -70
      halign = center
      valign = center

    }

    # USER AVATAR
    image {
      monitor = eDP-1
      path = $HOME/.face
      size = 80
      rounding = -1
      rotate = 0
      reload_time = -1
      border_size = 0
      position = 0, 220
      halign = center
      valign = center
    }

    image {
      monitor = HDMI-A-2
      path = $HOME/.face
      size = 80
      rounding = -1
      rotate = 0
      reload_time = -1
      border_size = 0
      position = 0, 200
      halign = center
      valign = center
    }

    # SHAPE
    shape {
      monitor = eDP-1
      size = 480, 480
      color = rgba(30, 30, 46, 0.65)
      rounding = 30
      rotate = 0
      xray = false
      position = 0, -25
      halign = center
      valign = center
    }

    shape {
      monitor = HDMI-A-2
      size = 550, 550
      color = rgba(30, 30, 46, 0.65)
      rounding = 30
      rotate = 0
      xray = false
      position = 0, -80
      halign = center
      valign = center
    }

    # NAME
    shape {
      monitor = eDP-1
      size = 300, 60
      color = ${kanagawaColors.color8}
      rounding = -1
      border_size = 4
      border_color = ${kanagawaColors.color0}
      xray = false
      rotate = 0
      position = 0, -100
      halign = center
      valign = center
    }

    label {
      monitor = eDP-1
      text =  $USER
      color = ${kanagawaColors.color15}
      font_size = 25
      font_family = ${fontFamily}
      position = 0, -100
      halign = center
      valign = center
    }

    shape {
      monitor = HDMI-A-2
      size = 300, 60
      color = ${kanagawaColors.color8}
      rounding = -1
      border_size = 4
      border_color = ${kanagawaColors.color0}
      xray = false
      rotate = 0
      position = 0, -200
      halign = center
      valign = center
    }

    label {
      monitor = HDMI-A-2
      text =  $USER
      color = ${kanagawaColors.color15}
      font_size = 25
      font_family = ${fontFamily}
      position = 0, -200
      halign = center
      valign = center
    }

    # INPUT PASSWORD FIELD
    input-field {
      monitor = eDP-1
      size = 300, 60
      outline_thickness = 4
      dots_size = 0.2
      dots_spacing = 0.2
      dots_center = true
      outer_color = ${kanagawaColors.color4}
      inner_color = ${kanagawaColors.color8}
      font_color = ${kanagawaColors.color15}
      fade_on_empty = false
      placeholder_text = <i><span foreground='##${kanagawaColors.color10accent}'>󰌾 Aduh </span> <span foreground='##${accentAlpha}'><b>gantengnya</b></span></i>
      hide_input = false
      fail_text = <i>Tolol, Coba lagi<b>($ATTEMPTS)</b></i>
      capslock_color = ${kanagawaColors.color3}
      position = 0, -185
      halign = center
      valign = center
    }

    # INPUT PASSWORD FIELD
    input-field {
      monitor = HDMI-A-2
      size = 300, 60
      outline_thickness = 4
      dots_size = 0.2
      dots_spacing = 0.2
      dots_center = true
      outer_color = ${kanagawaColors.color4}
      inner_color = ${kanagawaColors.color8}
      font_color = ${kanagawaColors.color15}
      fade_on_empty = false
      placeholder_text = <i><span foreground='##${kanagawaColors.color10accent}'>󰌾 Aduh </span> <span foreground='##${accentAlpha}'><b>gantengnya</b></span></i>
      hide_input = false
      fail_text = <i>Tolol, Coba lagi<b>($ATTEMPTS)</b></i>
      capslock_color = ${kanagawaColors.color3}
      position = 0, -285
      halign = center
      valign = center
    }
  '';
}
