# tunix — NixOS configuration
# ThinkPad T14 Gen 2a (AMD Ryzen 5 PRO 5650U, Vega iGPU)
# Managed as a flake — see flake.nix in this same directory

{ config, lib, pkgs, zen-browser, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ##### Nix & Home Manager #####

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.ucef = import ./home.nix;

  ##### Boot & hardware #####

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.graphics.enable = true;       # OpenGL/Vulkan on AMD Vega (llama.cpp)
  hardware.graphics.enable32Bit = true;  # Steam
  hardware.graphics.extraPackages = [ pkgs.rocmPackages.clr.icd ]; # OpenCL; fails
  zramSwap.enable = true;

  ##### Power, Updates & maintenance #####

  services.fwupd.enable = true;
  services.thinkfan.enable = true;

  services.power-profiles-daemon.enable = false; # TLP owns power mgmt
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "/etc/flake#tunix";
    dates = "daily";
    };

  ##### Networking & locale #####

  networking.hostName = "tunix";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Casablanca";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = "fr_FR.UTF-8";

  ##### Desktop: bare i3 #####

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    windowManager.i3.enable = true;
    desktopManager.xterm.enable = false;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/Pictures/walls/gangrenousflipper4walld.png
      xset r rate 200 40 &
    '';
  };
  
  services.displayManager.ly.enable = true;
  services.displayManager.defaultSession = "none+i3";

  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.variables.GTK_THEME = "Adwaita:dark";

  ##### Shell #####

  programs.zsh.enable = true;

  ##### User #####

  users.users.ucef = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ tree ];
  };

  ##### Applications #####

  nixpkgs.config.allowUnfree = true; # a sad necessity

  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    # cli / core
    vim git wget pulseaudio brightnessctl playerctl wl-clipboard xmodmap

    # i3 + desktop pieces
    i3lock i3status lxqt.lxqt-policykit dunst arandr kitty rofi
    pcmanfm xwallpaper mint-y-icons qutebrowser flameshot

    # gui apps
    gedit qpwgraph qownnotes zen-browser.packages."${pkgs.system}".default

    # dev
    python3 vscodium-fhs nixd

    # font 
    terminus_font
  ];

  ##### System #####

  # Do NOT change without reading the manual first — see:
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";
}