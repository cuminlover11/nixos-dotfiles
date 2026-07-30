{ config, pkgs, ...}:

{
  home.username = "ucef";
  home.homeDirectory = "/home/ucef";
  home.stateVersion = "26.05";


  programs.home-manager.enable = true;


  ##### Shell #####
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    shellAliases = {
      ls = "lsd --group-directories-first";
      la = "lsd -a --group-directories-first";
      lt = "lsd --tree";
      l = "lsd -l --group-directories-first";
      fortune = "fortune | cowsay -r | lolcat"; # TODO: install fortune
    };

    # Runs for every interactive shell — this is where anything
    # without a dedicated NixOS option goes (raw zsh, unchanged from your file)
    initContent = '' 
      zstyle ':completion:*' matcher-list 'm:{a-z1-A-Z}={A-Z1-a-z}'
      sudo-command-line() {
        [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"
        [[ $BUFFER == sudo\ * ]] && { BUFFER="''${BUFFER#sudo }"; CURSOR=$((CURSOR - 5)) } || { BUFFER="sudo $BUFFER"; CURSOR=$((CURSOR + 5)) }
      }
      zle -N sudo-command-line
      bindkey "\e\e" sudo-command-line
      setopt PROMPT_SUBST
      PROMPT='%B%F{red}%n%f@%F{yellow}%m%f:%F{green}%1~%f %#%b '
      pfetch
      '';  
  };
}