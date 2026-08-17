{config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      # enable extra modules you need, e.g. pulseaudio/i3 support
      i3Support = true;
      #i3GapsSupport = true;
      alsaSupport = true;
      pulseSupport = true;
      mpdSupport = true;
    };

    script = "polybar main &"; # launch command, runs on start 
    
    config = {
      "colors" = {
         background = "#1a1f16";   # dark olive base
         foreground = "#c9c9a0";   # muted khaki text
         primary = "#6b7a3d";      # olive accent
         alert = "#a3593a";        # rust/warning tone
         disabled = "#4a4f3e";
};

      "bar/main" = {
        background = "\${colors.background}";
        foreground = "\${colors.foreground}";
        width = "100%";
        height = "22pt";
        fixed-center = true;
        top = true;

        line-size = 2;
        line-color = "#f00";

        border-size = 0;

        padding-left = 0;
        padding-right = 0;

        modules-left = "i3";
        modules-center = "date";
        modules-right = "battery";

        tray-position = "right";
        tray-padding = 3;
        scroll-up = "i3wm-wsnext";
        scroll-down = "i3wm-wsprev";
      };     # equivalent to [bar/main] in polybar's ini syntax

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        };

        "module/filesystem" = {
          type = "internal/fs";
          interval = 10;

          mount-0 = "/";

          format-mounted-underline = "#06E87A";
          label-mounted = "%mountpoint%: %free%";
   };

      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%H:%M:%S";
      };  # equivalent to [module/date]

      "module/battery" = {
        type = "internal/battery";
        format-charging-foreground = "\${colors.primary}";
        format-discharging-foreground = "\${colors.alert}";
        battery = "BAT0";       # check yours: cat /sys/class/power_supply/BAT*/uevent
        adapter = "AC";
      };
    };
  };

}