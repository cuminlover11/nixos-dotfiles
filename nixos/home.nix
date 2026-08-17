{ config, pkgs, inputs, ...}:

{
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

  imports = [ inputs.areofyl-fetch.homeManagerModules.default ];
  
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
      pulseSupport = true;
    };
    script = "polybar main &"; # launch command, runs on start 
    config = {
      "bar/main" = {
        width = "100%";
        height = "24pt";
        modules-center = "date";
      };     # equivalent to [bar/main] in polybar's ini syntax
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%H:%M";
      };  # equivalent to [module/date]
    };
  };

  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    autosuggestion = {
      enable = true;
      highlight = "fg=#ff00ff,bg=cyan,bold";
    };

    shellAliases = {
      ls = "lsd --group-directories-first";
      la = "lsd -a --group-directories-first";
      lt = "lsd --tree";
      l = "lsd -l --group-directories-first";
      cat = "bat --paging=never";
      cow = "fortune | cowsay -r | lolcat"; 
    };

    initContent = '' 
      zstyle ':completion:*' matcher-list 'm:{a-z1-A-Z}={A-Z1-a-z}'
      sudo-command-line() {
        [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
        [[ $BUFFER == sudo\ * ]] && { BUFFER="''${BUFFER#sudo }"; CURSOR=$((CURSOR - 5)) } || { BUFFER="sudo $BUFFER"; CURSOR=$((CURSOR + 5)) }
      }
      zle -N sudo-command-line
      bindkey "\e\e" sudo-command-line
      setopt PROMPT_SUBST
      PROMPT='%B%F{red}%n%f@%F{yellow}%m%f in %F{green}%1~%f%b '
      pfetch
      '';  
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