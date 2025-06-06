{
  inputs,
  pkgs,
  config,
  ...
}: let
  spotify-adblock = pkgs.rustPlatform.buildRustPackage rec {
    pname = "spotify-adblock";
    version = "8e0312d6085a6e4f9afeb7c2457517a75e8b8f9d";
    src = pkgs.fetchFromGitHub {
      owner = "abba23";
      repo = "${pname}";
      rev = "${version}";
      hash = "sha256-nwiX2wCZBKRTNPhmrurWQWISQdxgomdNwcIKG2kSQsE=";
    };
    cargoLock.lockFile = "${src}/Cargo.lock";
  };

  cliphist-img-display = pkgs.buildGoModule rec {
    pname = "cliphist-wofi-img";
    version = "0.0.3";

    src = pkgs.fetchFromGitHub {
      owner = "pdf";
      repo = "${pname}";
      rev = "v${version}";
      hash = "sha256-2N7LPetEMRXVWXQ4ls3deEZmT/cxztBIGwAz0IUbnDQ=";
    };

    vendorHash = null;
  };
in {
  imports = [./hyprlock.nix ./hypridle.nix];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    plugins = [
      "${inputs.hy3.packages.${pkgs.stdenv.hostPlatform.system}.hy3}/lib/libhy3.so"
      "${inputs.hypr-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors}/lib/libhypr-dynamic-cursors.so"
      "${inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling}/hyprscrolling.so"
      "${inputs.Hyprspace.packages.${pkgs.stdenv.hostPlatform.system}.Hyprspace}/lib/libHyprspace.so"
    ];
    settings = {
      exec-once = [
        "hyprpanel"
        "/tmp/scripts/start_boot"
        "udiskie --appindicator --menu-update-workaround --file-manager nautilus --tray --notify --automount"
        "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
      ];

      monitor = ["eDP-1, 1366x768@60, 0x0, 1" "HDMI-A-2, 1920x1080@74.97, 0x768, 1"];

      input = {
        kb_file = "";
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        numlock_by_default = true;

        follow_mouse = true;
        mouse_refocus = true;

        sensitivity = -0.3;
        accel_profile = "adaptive";

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = false;
          drag_lock = true;
          tap-and-drag = true;
        };
      };
      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(C0A36Ee7) rgba(DCD7BAff) 45deg";
        "col.inactive_border" = "0x3636462E";
        no_border_on_floating = false;
        layout = "hy3";
        snap = {
          enabled = true;
          window_gap = 35;
          monitor_gap = 35;
        };
      };

      decoration = {
        rounding = 1;
        active_opacity = 1;
        inactive_opacity = 0.9;

        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
          input_methods = 1;
          xray = false;
          ignore_opacity = false;
        };
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        disable_autoreload = false;
        mouse_move_enables_dpms = true;
        vfr = true;
        font_family = "CaskaydiaMono Nerd Font";
        vrr = 1;
        render_ahead_of_time = false;
        animate_manual_resizes = true;
        mouse_move_focuses_monitor = true;
        enable_swallow = true;
        animate_mouse_windowdragging = true;
        middle_click_paste = false;
      };

      cursor = {
        default_monitor = "LG Electronics";
        sync_gsettings_theme = true;
        no_hardware_cursors = false;
        use_cpu_buffer = true;
      };

      render = {
        explicit_sync = true;
        explicit_sync_kms = true;
        cm_fs_passthrough = true;
      };

      xwayland = {
        enabled = true;
        use_nearest_neighbor = false;
        force_zero_scaling = true;
      };

      animations = {
        enabled = true;
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1;"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];
        animation = [
          "windows, 1, 3, hyprnostretch, gnomed"
          "windowsIn, 1, 3, md3_standard, gnomed"
          "windowsOut, 1, 3, md3_accel, gnomed"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      "$term" = "kitty";
      "$screencapture" = "/tmp/scripts/screen-capture.sh";
      "$files" = "footclient --title=yaziFM yazi";
      "$zen-browser" = "zen";
      "$vm" = "vmware";
      "$launcher" = "rofi -show drun";
      "$powermenu" = "wlogout";
      "$colorpick" = "/tmp/scripts/picker.sh";
      "$notifhistory" = "${pkgs.astal.io}/bin/astal -i hyprpanel -t notificationsmenu";
      "$calendar" = "${pkgs.astal.io}/bin/astal -i hyprpanel -t calendarmenu";
      "$dashboard" = "${pkgs.astal.io}/bin/astal -i hyprpanel -t dashboardmenu";
      "$emoji" = "${pkgs.rofimoji}/bin/rofimoji --selector wofi";
      "$spotify" = "spotify";
      "$discord" = "vesktop";
      "$clipmanager" = "kitty --class clipse -e clipse";
      "$modalt" = "ALT";
      "$mod" = "SUPER";

      bind =
        [
          "$modalt, RETURN, exec, $term"
          "$modalt, F, exec, $zen-browser"
          "$modalt, E, exec, $files"
          "SHIFT $modalt, C, exec, $clipmanager"
          "$modalt, C, exec, $emoji"
          "SHIFT $modalt, E, exec, /tmp/scripts/ags_connect"
          "SHIFT $modalt, D, exec, $discord"
          "$modalt, SPACE, exec, $launcher"
          "$modalt, S, exec, $spotify"
          "$mod, P, exec, $dashboard"
          "SuperShift, C, exec, $calendar"
          "$modalt, D, exec, $powermenu"
          "$modalt, T, exec, telegram-desktop"
          "SHIFT $modalt, P, exec, $colorpick"
          "$mod, S, exec, $screencapture"
          "$mod, W, exec, $notifhistory"

          "SHIFT $modalt, TAB, togglefloating"
          "$modalt, Q, killactive"
          "$modalt, P, pseudo"
          "SHIFT $modalt, RETURN, fullscreen"
          "SuperShift, S, layoutmsg, togglesplit"

          # Change Workspace Mode
          "SuperShift, F, workspaceopt, allfloat"
          "SuperShift, P, workspaceopt, allpseudo"

          "$mod, Tab, cyclenext"
          "$mod, Tab, bringactivetotop"
          "$modalt, left, movefocus, l"
          "$modalt, right, movefocus, r"
          "$modalt, up, movefocus, u"
          "$modalt, down, movefocus, d"

          # Alternative Movefocus
          "$mod CTRL, left, exec, hyprctl dispatch hy3:movefocus l"
          "$mod CTRL, right, exec, hyprctl dispatch hy3:movefocus r"
          "$mod CTRL, up, exec, hyprctl dispatch hy3:movefocus u"
          "$mod CTRL, down, exec, hyprctl dispatch hy3:movefocus d"

          "SHIFT $modalt, G, exec, hyprctl dispatch hy3:makegroup tab"

          "$mod, left, exec, hyprctl dispatch hy3:movewindow l"
          "$mod, right, exec, hyprctl dispatch hy3:movewindow r"
          "$mod, up, exec, hyprctl dispatch hy3:movewindow u"
          "$mod, down, exec, hyprctl dispatch hy3:movewindow d"
          "$modalt CTRL, left, resizeactive, -20 0"
          "$modalt CTRL, right, resizeactive, 20 0"
          "$modalt CTRL, up, resizeactive, 0 -20"
          "$modalt CTRL, down, resizeactive, 0 20"
          "SHIFT $modalt, up, workspace, e+1"
          "SHIFT $modalt, down, workspace, e-1"
          "SHIFT $modalt, right, workspace, r+1"
          "SHIFT $modalt, left, workspace, r-1"
          "$modalt, mouse_down, workspace, e+1"
          "$modalt, mouse_up, workspace, e-1"

          ", XF86AudioStop, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          ", XF86AudioLowerVolume,exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioRaiseVolume,exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          "$modalt, TAB, exec, hyprctl dispatch overview:toggle"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList
            (i: let ws = i + 1; in ["$mod, ${toString ws}, movetoworkspace, ${toString ws}"])
            9)
        );

      bindm = ["$modalt, mouse:273, resizewindow" "$modalt, mouse:272, movewindow"];
      bindr = [
        "CAPS, Caps_Lock, exec, swayosd-client --caps-lock"
        ", toggle_numlock, exec, swayosd-client --num-lock"
      ];

      windowrulev2 = [
        "float,class:^(pavucontrol)$"
        "float,title:^(Media viewer)$"
        "float,title:^(Volume Control)$"
        "float,title:^(Picture-in-Picture)$"
        "float,class:^(clipse)"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,class:^(zen-twilight),title:^()"
        "float,title:^(branchdialog)$"
        "float,title:^(Login - Akun Google — Zen Twilight)$"
        "float,title:^(Confirm to replace files)"
        "float,title:^(File Operation Progress)"
        "float,class:^(org.twosheds.iwgtk)$"
        "float,title:^(iwgtk)$"
        "float,class:^(blueman-manager)$"
        "float,title:^(Bluetooth Devices)$"
        "float,class:^(Rofi)$"
        "float,initialTitle:^(yaziFM)$"
        "float,title:^(Image Properties)$"
        "float,class:^(nemo),title:.*Properties"
        "float,class:^(zen|zen-twilight),title:^(Sign In - Google Accounts — Zen Twilight|Sign In - Google Accounts — Zen)"
        "move 40 44%,title:^(iwgtk)$"
        "move 40 58%,title:^(Bluetooth Devices)$"
        "center,floating:1,title:^(Steam|Sign in to Steam)"
        "center,title:^(Volume Control)$"
        "center,title:^(Starting Apache NetBeans IDE)$"
        "center,class:^(zen|zen-twilight),title:^(Sign In - Google Accounts — Zen Twilight|Sign In - Google Accounts — Zen)"
        "center,title:^(Import Hyprpanel Theme)$"
        "center,title:^(hyprpanel-settings)$"
        "center,title:^(Hyprland Polkit Agent)$"
        "center,title:^(rofi - )$"
        "center,title:^(rofi -  myamusashi@nixos)$"
        "center,title:^(rofi - APPS)$"
        "center,initialTitle:^(yaziFM)$"
        "center,title:^(Image Properties)$"
        "center,title:^(Enter name of file to save to…)$"
        "center,title:^(vesktop)$"
        "center,class:^(eu.),title:^(Properties|Select icon)"
        "size 360 363,class:^(eu.),title:^(Properties)"
        "size 622 652,class:^(clipse)"
        "size 450 420,class:^(zen|zen-twilight),title:^(Sign In - Google Accounts — Zen Twilight|Sign In - Google Accounts — Zen)"
        "size 351 113,class:^(zen|zen-twilight),title:^()"
        "size 480 300,title:^(Starting Apache NetBeans IDE)$"
        "size 300 350,title:^(vesktop)$"
        "size 954 641,title:^(Login - Akun Google — Zen Twilight)$"
        "size 800 600,title:^(hyprpanel-settings)$"
        "size 800 600,title:^(Import Hyprpanel Theme)$"
        "size 800 600,title:^(Hyprland Polkit Agent)$"
        "size 800 600,class:^(download)$"
        "size 1096 520,initialTitle:^(yaziFM)$"
        "size 800 600,title:^(Volume Control)$"
        "size 493 254,title:^(Image Properties)$"
        "size 505 600,title:^(iwgtk)$"
        "size 885 463,title:^(Enter name of file to save to…)$"
        "size 652 310,title:^(Bluetooth Devices)$"
        "stayfocused,class:^(clipse)"
        "idleinhibit focus,class:^(mpv)$"
        "idleinhibit fullscreen,class:^(firefox)$"
        "opacity 0.90,title:^(Spotify)$"
        "opacity 1 override,class:^(zen|zen-twilight)$"
        "opacity 0.95,class:^(nemo)$"
        "noblur,xwayland:1"
        "noborder,initialClass:^(Xdg-desktop-portal-gtk)$"
        "bordersize 0,initialClass:^(Xdg-desktop-portal-gtk)$"
      ];

      layerrule = [
        "animation popin 80%, wofi"
        "animation popin 95%, notifications-window"
        "animation popin 95%, mediamenu"
        "animation popin 95%, dashboardmenu"
        "animation popin 95%, networkmenu"
        "animation popin 95%, audiomenu"
        "animation popin 95%, bluetoothmenu"
        "animation popin 95%, energymenu"
        "animation popin 95%, calendarmenu"
        "animation popin 95%, notificationsmenu"
        "animation popin 95%, rofi"
        "animation popin 95%, launcher"
        "blur, rofi"
        "blur, launcher"
      ];

      permission = [
        "${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland, screencopy, allow"
      ];

      plugin = {
        overview = {
          # Color workspaces window
          dragAlpha = 0.5;
          panelColor = "rgba(46, 52, 64, 0.5)";
          panelBorderColor = "rgb(243, 139, 168)";

          # Layout
          disableBlur = false;
          workspaceMargin = 20;
          panelHeight = 250;
          panelBorderWidth = 5;
          workspaceBorderSize = 5;
          hideBackgroundLayers = false;
          hideTopLayers = true;
          hideOverlayLayers = false;
          hideRealLayers = false;
          onBottom = true;
          overrideGaps = true;
          adaptiveHeight = true;
          centerAligned = true;

          # Event
          affectStrut = true;
          autoDrag = true;
          autoScroll = false;
          drawActiveWorkspace = true;
          showNewWorkspace = true;
          showEmptyWorkspace = true;
          showSpecialWorkspace = false;
          exitOnClick = false;

          # Animation
          overrideAnimSpeed = 0;
        };

        hy3 = {
          # 0 - always show gaps
          # 1 - hide gaps with a single window onscreen
          # 2 - 1 but also show the window border
          no_gaps_when_only = 0; # default: 0

          # 0 = remove the nested group
          # 1 = keep the nested group
          # 2 = keep the nested group only if its parent is a tab group
          node_collapse_policy = 0; # default: 2

          # offset from group split direction when only one window is in a group
          group_inset = 10; # default: 10

          # if a tab group will automatically be created for the first window spawned in a workspace
          tab_first_window = true;

          tabs = {
            height = 5; # default: 15
            padding = 5; # default: 5

            # the tab bar should animate in/out from the top instead of below the window
            from_top = false; # default: false
            rounding = 3; # default: 3
            render_text = false; # default: true
            text_center = false; # default: false
            text_font = "Sans"; # default: Sans
            text_height = 5; # default: 8
            text_padding = 1; # default: 3
            col = {
              active = "0xf38ba8ff";
              urgent = "0xffff4f4f";
              inactive = "0x80808080";

              text = {
                active = "0xff000000";
                urgent = "0xff000000";
                inactive = "0xff000000";
              };
            };
          };

          autotile = {
            enable = true; # default: false;
            # make autotile-created groups ephemeral
            ephemeral_groups = true; # default: true

            # if a window would be squished smaller than this width, a vertical split will be created
            # -1 = never automatically split vertically
            # 0 = always automatically split vertically
            # <number> = pixel height to split at
            trigger_width = 0; # default: 0

            # if a window would be squished smaller than this height, a horizontal split will be created
            # -1 = never automatically split horizontally
            # 0 = always automatically split horizontally
            # <number> = pixel height to split at
            trigger_height = 0; # default: 0

            # a space or comma separated list of workspace ids where autotile should be enabled
            # it's possible to create an exception rule by prefixing the definition with "not:"
            # workspaces = 1,2 # autotiling will only be enabled on workspaces 1 and 2
            # workspaces = not:1,2 # autotiling will be enabled on all workspaces except 1 and 2
            "workspaces" = "all"; # default: all
          };
        };
        dynamic-cursors = {
          # enables the plugin
          enabled = true;

          # sets the cursor behaviour, supports these values:
          # tilt    - tilt the cursor based on x-velocity
          # rotate  - rotate the cursor based on movement direction
          # stretch - stretch the cursor shape based on direction and velocity
          # none    - do not change the cursors behaviour
          mode = "stretch";

          # minimum angle difference in degrees after which the shape is changed
          # smaller values are smoother, but more expensive for hw cursors
          threshold = 1;

          # for mode = rotate
          rotate = {
            # length in px of the simulated stick used to rotate the cursor
            # most realistic if this is your actual cursor size
            length = 20;

            # clockwise offset applied to the angle in degrees
            # this will apply to ALL shapes
            offset = 0.0;
          };

          # for mode = tilt
          tilt = {
            # controls how powerful the tilt is, the lower, the more power
            # this value controls at which speed (px/s) the full tilt is reached
            limit = 5000;

            # relationship between speed and tilt, supports these values:
            # linear             - a linear function is used
            # quadratic          - a quadratic function is used (most realistic to actual air drag)
            # negative_quadratic - negative version of the quadratic one, feels more aggressive
            function = "negative_quadratic";
          };

          # for mode = stretch
          stretch = {
            # controls how much the cursor is stretched
            # this value controls at which speed (px/s) the full stretch is reached
            limit = 3000;

            # relationship between speed and stretch amount, supports these values:
            # linear             - a linear function is used
            # quadratic          - a quadratic function is used
            # negative_quadratic - negative version of the quadratic one, feels more aggressive
            function = "negative_quadratic";
          };

          # configure shake to find
          # magnifies the cursor if its is being shaken
          shake = {
            # enables shake to find
            enabled = false;

            # use nearest-neighbour (pixelated) scaling when shaking
            # may look weird when effects are enabled
            nearest = true;

            # controls how soon a shake is detected
            # lower values mean sooner
            threshold = 6.0;

            # magnification level immediately after shake start
            base = 4.0;
            # magnification increase per second when continuing to shake
            speed = 4.0;
            # how much the speed is influenced by the current shake intensitiy
            influence = 0.0;

            # maximal magnification the cursor can reach
            # values below 1 disable the limit (e.g. 0)
            limit = 0.0;

            # time in millseconds the cursor will stay magnified after a shake has ended
            timeout = 2000;

            # show cursor behaviour `tilt`, `rotate`, etc. while shaking
            effects = false;

            # enable ipc events for shake
            # see the `ipc` section below
            ipc = false;
          };
        };
      };
    };
  };
}
