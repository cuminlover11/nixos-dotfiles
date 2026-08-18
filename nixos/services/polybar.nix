{config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = "";
    package = pkgs.polybar.override {
      # enable extra modules you need, e.g. pulseaudio/i3 support
      i3Support = true;
      #i3GapsSupport = true;
      alsaSupport = true;
      pulseSupport = true;
      mpdSupport = true;
    };

    
    config = {
      "colors" = {
         background = "#1a1f16";   # dark olive base
         foreground = "#c9c9a0";   # muted khaki text
         primary = "#6b7a3d";      # olive accent
         alert = "#a3593a";        # rust/warning tone
         disabled = "#4a4f3e";
};

      "bar/main" = {
        # Shape & look
        width = "100%";
        height = "20pt";
        radius = 0;
        fixed-center = true;
        top = true;
        background = "\${colors.background}";
        foreground = "\${colors.foreground}";

        line-size = 3;
        line-color = "#f00";

        #override-redirect = true;
        enable-ipc = true;

        border-size = 0;

        padding-left = 0;
        padding-right = 0;

        modules-left = "i3";
        modules-center = "date";
        modules-right = "cpu memory temperature wlan pulseaudio battery tray";

        module-margin-left = 1;
        module-margin-right = 1;
      };     # equivalent to [bar/main] in polybar's ini syntax

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;

        label-mode-padding = 2;
        label-mode-foreground = "#000";
        label-mode-background = "\${colors.primary}";

        # focused = Active workspace on focused monitor
        label-focused = "%index%";
        label-focused-background = "\${colors.primary}";
        label-focused-padding = 2;

        # unfocused = Inactive workspace on any monitor
        label-unfocused = "%index%";
        label-unfocused-background = "\${colors.background}";
        label-unfocused-padding = 2;

        # visible = Active workspace on unfocused monitor
        label-visible = "%index%";
        label-visible-background = "\${colors.primary}";
        label-visible-padding = 2;

        # urgent = Workspace with urgency hint set
        label-urgent = "%index%";
        label-urgent-background = "\${colors.alert}";
        label-urgent-padding = 2;

        pin-workspaces = true;
        show-urgent = true;
        enable-click = true;
        };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%H:%M:%S";
      };  # equivalent to [module/date]

      "module/battery" = {
        type = "internal/battery";
        full-at = 100;
        low-at = 15;
        battery = "BAT0";
        adapter = "AC";

        format-charging = "<label-charging>";
        format-charging-foreground = "\${colors.primary}";
        label-charging = "BAT: %percentage%% (charging)";

        format-discharging = "<label-discharging>";
        format-discharging-foreground = "\${colors.alert}";
        label-discharging = "BAT: %percentage%%";
      };


      "module/tray" = {
        type = "internal/tray";
        
        format-margin = 8;
        tray-spacing = 8;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "VOL: <label-volume>";
        label-volume = "%percentage%%";
        label-muted = "MUTED";
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "wlp3s0";  # check yours: ip link | grep wl
        interval = 3;
        format-connected = "<label-connected>";
        label-connected = "%essid%";
        format-disconnected = "";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "CPU: ";
        label = "%percentage:2%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "RAM: ";
        label = "%percentage_used%%";
      };

      "module/temperature" = {
        type = "internal/temperature";
        thermal-zone = 0;
        warn-temperature = 75;
        format-prefix = "TEMP: ";
        label = "%temperature-c%";
      };
    };
  };

}