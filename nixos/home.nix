{ config, pkgs, inputs, ...}:

{
  imports = [
    inputs.areofyl-fetch.homeManagerModules.default
    ./home/zsh.nix
  ];

  home.username = "ucef";
  home.homeDirectory = "/home/ucef";
  home.sessionPath = [ "$HOME/.local/bin"];
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "qutebrowser";
  };

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.desktopEntries.nsxiv-rifle = {
  name = "nsxiv (rifle)";
  exec = "nsxiv-rifle %f";
  terminal = false;
  mimeType = [ "image/jpeg" "image/png" "image/gif" "image/webp" ];
};

xdg.mimeApps = {
  enable = true;
  defaultApplications = {
    "image/jpeg" = "nsxiv-rifle.desktop";
    "image/png" = "nsxiv-rifle.desktop";
    "image/gif" = "nsxiv-rifle.desktop";
    "image/webp" = "nsxiv-rifle.desktop";
  };
};
  
  programs.fetch = {
    enable = true;
    labelColor = "red";
    info = [
      "os"
      "host"
      "kernel"
      "uptime"

      "display"
      "wm"

      "cpu"
      "gpu"
      "memory"
      "disk"
      "battery"

      "locale"
      "colors"

    ];
    speed = 1.0;
    spin = "xy";
  };
  
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

  programs.kitty = {
    enable = true;
    font = {
      name = "FreeMono";
      size = 11;
    };

    extraConfig = ''
      remember_window_size no
      enable_audio_bell no
      background_opacity 0.75
      startup_mode windowed
    '';
  };

  programs.rofi = {
  enable = true;
  theme = "Arc-Dark";
  extraConfig = {
    show-icons = true;
    icon-theme = "Mint-Y";
  };
};

# notifications
services.dunst = {
  enable = true;
  settings = {
    global = {
      origin = "top-right";
      font = "Terminus 9";
    };
  };
};

# screenshots
services.flameshot = {
  enable = true;
  settings = {
    General = {
      savePath = "/home/ucef/Pictures/Screenshots";
      disabledTrayIcon = true;
      showStartupLaunchMessage = false;
      saveAsFileExtension = ".png";
      showDesktopNotification = true;
      showAbortNotification = false;
      showHelp = true;
      showSidePanelButton = true;
      uiColor = "#6b6b47";
      contrastUiColor = "#282922";
      drawColor = "#c41e1e";
    };
  };
};

home.file.".local/bin/nsxiv-rifle" = {
  source = ./scripts/nsxiv-rifle;
  executable = true;
};

home.packages = with pkgs; [
  # cli
  bat
  lsd
  btop

  # LARPing 
  fortune
  cowsay
  lolcat
  pfetch

  # tools
  pywal
  nsxiv

  # user apps
  gimp-with-plugins
  prismlauncher
  vesktop
];

}