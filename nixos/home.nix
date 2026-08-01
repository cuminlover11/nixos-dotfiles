{ config, pkgs, ...}:

{
  home.username = "ucef";
  home.homeDirectory = "/home/ucef";
  home.stateVersion = "26.05";


  programs.home-manager.enable = true;

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

  ##### Shell #####
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
      PROMPT='%B%F{red}%n%f@%F{yellow}%m%f in %F{green}%1~%f %#%b '
      pfetch
      '';  
  };

home.packages = with pkgs; [
  # cli
  bat
  fortune
  cowsay
  lolcat	
  lsd
  btop
  pfetch
];

}