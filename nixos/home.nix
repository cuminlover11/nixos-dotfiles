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