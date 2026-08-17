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
        bottom = true;

        line-size = 2;
        line-color = "#f00";

        border-size = 0;

        padding-left = 0;
        padding-right = 0;

        module-margin-left = 1;
        module-margin-right = 1;
      

        modules-left = "i3";
        modules-center = "date";
        modules-right = "battery";
      };     # equivalent to [bar/main] in polybar's ini syntax

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false; 

        # Only show workspaces on the same output as the bar
        pin-workspaces = true;

        label-mode-padding = 2;
          label-mode-foreground = "#000";
          label-mode-background = "\${colors.primary}";

          # focused = "Active workspace on focused monitor";
          label-focused = "%index%";
          label-focused-background = "\${colors.primary}";
          label-focused-padding = 2;

          # unfocused = "Inactive workspace on any monitor";
          label-unfocused = "%index%";
          label-unfocused-background = "\${colors.background}";
          label-unfocused-padding = 2;

          # visible = "Active workspace on unfocused monitor";
          label-visible = "%index%";
          label-visible-background = "\${colors.primary}";
          label-visible-padding = 2;

          # urgent = "Workspace with urgency hint set";
          label-urgent = "%index%";
          label-urgent-background = "\${colors.alert}";
          label-urgent-padding = 2;

          label-separator = "|";
          label-separator-padding = 2;
          label-separator-foreground = "#ffb52a";
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
        bottom = true;

        line-size = 2;
        line-color = "#f00";

        border-size = 0;

        padding-left = 0;
        padding-right = 0;

        module-margin-left = 1;
        module-margin-right = 1;
      

        modules-left = "i3";
        modules-center = "date";
        modules-right = "battery";
      };     # equivalent to [bar/main] in polybar's ini syntax

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false; 

        # Only show workspaces on the same output as the bar
        pin-workspaces = true;

        label-mode-padding = 2;
          label-mode-foreground = "#000";
          label-mode-background = "\${colors.primary}";

          # focused = "Active workspace on focused monitor";
          label-focused = "%index%";
          label-focused-background = "\${colors.primary}";
          label-focused-padding = 2;

          # unfocused = "Inactive workspace on any monitor";
          label-unfocused = "%index%";
          label-unfocused-background = "\${colors.background}";
          label-unfocused-padding = 2;

          # visible = "Active workspace on unfocused monitor";
          label-visible = "%index%";
          label-visible-background = "\${colors.primary}";
          label-visible-padding = 2;

          # urgent = "Workspace with urgency hint set";
          label-urgent = "%index%";
          label-urgent-background = "\${colors.alert}";
          label-urgent-padding = 2;

          label-separator = "|";
          label-separator-padding = 2;
          label-separator-foreground = "#ffb52a";
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