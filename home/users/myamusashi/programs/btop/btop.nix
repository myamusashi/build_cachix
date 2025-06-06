{
  home.file = {
    ".config/btop/themes/kanagawa.themes" = {
      enable = true;
      text = ''
        # Main background, empty for terminal default, need to be empty if you want transparent background
        theme[main_bg]="#16161D"

        # Main text color
        theme[main_fg]="#DCD7BA"

        # Title color for boxes
        theme[title]="#DCD7BA"

        # Highlight color for keyboard shortcuts
        theme[hi_fg]="#E82424"

        # Background color of selected items
        theme[selected_bg]="#363646"

        # Foreground color of selected items
        theme[selected_fg]="#D27E99"

        # Color of inactive/disabled text
        theme[inactive_fg]="#223249"

        # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
        theme[graph_text]="#E6C384"

        # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
        theme[proc_misc]="#98BB6C"

        # Cpu box outline color
        theme[cpu_box]="#E6C384"

        # Memory/disks box outline color
        theme[mem_box]="#E6C384"

        # Net up/down box outline color
        theme[net_box]="#E6C384"

        # Processes box outline color
        theme[proc_box]="#E6C384"

        # Box divider line and small boxes line color
        theme[div_line]="#E6C384"

        # Temperature graph colors
        theme[temp_start]="#98BB6C"
        theme[temp_mid]=""
        theme[temp_end]="#E82424"

        # CPU graph colors
        theme[cpu_start]="#8EC07C"
        theme[cpu_mid]="#FFA066"
        theme[cpu_end]="#E82424"

        # Mem/Disk free meter
        theme[free_start]="#E82424"
        theme[free_mid]="#FFA066"
        theme[free_end]="#8EC07C"

        # Mem/Disk cached meter
        theme[cached_start]="#458588"
        theme[cached_mid]="#83A598"
        theme[cached_end]="#8EC07C"

        # Mem/Disk available meter
        theme[available_start]="#E82424"
        theme[available_mid]="#D65D0E"
        theme[available_end]="#FABD2F"

        # Mem/Disk used meter
        theme[used_start]="#8EC07C"
        theme[used_mid]="#D65D0E"
        theme[used_end]="#E82424"

        # Download graph colors
        theme[download_start]="#98BB6C"
        theme[download_mid]="#689d6A"
        theme[download_end]="#6A9589"

        # Upload graph colors
        theme[upload_start]="#E82424"
        theme[upload_mid]="#D65d0E"
        theme[upload_end]="#FABF2F"

        # Process box color gradient for threads, mem and cpu usage
        theme[process_start]="#8EC07C"
        theme[process_mid]="#FE8019"
        theme[process_end]="#E82424"
      '';
    };
  };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "kanagawa";
      theme_background = false;
      truecolor = false;
      force_tty = false;
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
      vim_keys = false;
      rounded_corners = false;
      graph_symbol = "braille";
      graph_symbol_cpu = "default";
      graph_symbol_gpu = "default";
      graph_symbol_mem = "default";
      graph_symbol_net = "default";
      graph_symbol_proc = "default";
      shown_boxes = "cpu mem net proc";
      update_ms = 1000;
      proc_sorting = "user";
      proc_reversed = true;
      proc_tree = false;
      proc_colors = true;
      proc_gradient = true;
      proc_per_core = true;
      proc_mem_bytes = true;
      proc_cpu_graphs = true;
      proc_info_smaps = false;
      proc_left = false;
      proc_filter_kernel = false;
      proc_aggregate = false;
      cpu_graph_upper = "Auto";
      cpu_graph_lower = "idle";
      show_gpu_info = "Auto";
      cpu_invert_lower = true;
      cpu_single_graph = false;
      cpu_bottom = false;
      show_uptime = true;
      check_temp = true;
      cpu_sensor = "Auto";
      show_coretemp = false;
      cpu_core_map = "";
      temp_scale = "celsius";
      base_10_sizes = false;
      show_cpu_freq = true;
      clock_format = "%X";
      background_update = true;
      custom_cpu_name = "sigma";
      disks_filter = "";
      mem_graphs = true;
      mem_below_net = false;
      zfs_arc_cached = true;
      show_swap = true;
      swap_disk = true;
      show_disks = true;
      only_physical = true;
      use_fstab = true;
      zfs_hide_datasets = false;
      disk_free_priv = false;
      show_io_stat = true;
      io_mode = true;
      io_graph_combined = true;
      io_graph_speeds = "";
      net_download = 100;
      net_upload = 100;
      net_auto = true;
      net_sync = true;
      net_iface = "";
      show_battery = true;
      selected_battery = "Auto";
      show_battery_watts = true;
      log_level = "WARNING";
      nvml_measure_pcie_speeds = true;
      gpu_mirror_graph = true;
    };
  };
}
