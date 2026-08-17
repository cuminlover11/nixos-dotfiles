{config, pkgs, ...}:

{
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
      fortunecow = "fortune | cowsay -r | lolcat"; 
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
}