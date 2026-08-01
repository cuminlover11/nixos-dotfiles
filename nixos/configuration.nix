# tunix — NixOS configuration
# ThinkPad T14 Gen 2a (AMD Ryzen 5 PRO 5650U, Vega iGPU)
# Managed as a flake — see flake.nix in this same directory

{ config, lib, pkgs, ... }:

{
  imports = 
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup"; # Converts duplicate config files into backup files
  home-manager.users.ucef = import ./home.nix;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  programs.zsh.enable = true;

  ##### Boot & hardware #####

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.graphics.enable = true; # needed for OpenGL/Vulkan on AMD Vega (llama.cpp)

  zramSwap.enable = true;


  ##### ThinkPad-specific power & maintenance #####

  services.fwupd.enable = true;      # firmware updates via LVFS
  services.thinkfan.enable = true;   # custom fan curve

  # TLP owns power management — must disable the default daemon to avoid conflicts
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80; # caps charging to slow battery wear
    };
  };


  ##### Networking & locale #####

  networking.hostName = "tunix";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Casablanca";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "fr_FR.UTF-8";
  };


  ##### Desktop: bare i3, no DE #####

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    desktopManager.xterm.enable = false;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/Pictures/walls/nixos.png
      xset r rate 200 40 &
    '';
  };
  services.displayManager.defaultSession = "none+i3";

  services.picom.enable = true; # compositor — i3 has none built in; needed for kitty transparency

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.variables = {
    GTK_THEME = "Adwaita:dark";
  };

  ##### User #####
  users.users.ucef = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [ tree ];
  };

  ##### Applications #####

  nixpkgs.config.allowUnfree = true; # needed for steam, vscodium-fhs base

  programs.firefox.enable = true;
  programs.obs-studio.enable = true;
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    # cli / core
    vim
    git
    wget

    # i3 desktop pieces
    kitty
    rofi
    pcmanfm
    wl-clipboard
    xwallpaper
    mint-y-icons
    qutebrowser

    # gui apps
    gedit
    qownnotes
    vesktop
    gimp-with-plugins

    # dev
    vscodium-fhs
    nixd
  ];


  ##### System #####

  # Do NOT change without reading the manual first — see:
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "26.05";
}