{ config, lib, pkgs, ... }:
{
  # kernel modules to load
  boot.kernelModules = [ "cpufreq_stats" ]; # monitoring module

  # kernel tweaks
  
  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 1500;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.graphics.enable = true;       # OpenGL/Vulkan on AMD Vega (llama.cpp)
  hardware.graphics.enable32Bit = true;  # Steam
  hardware.graphics.extraPackages = [ pkgs.rocmPackages.clr.icd ]; # OpenCL; fails

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
      };
    };
  };

  zramSwap.enable = true;
  services.fwupd.enable = true;

  services.power-profiles-daemon.enable = false; # TLP owns power mgmt
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  environment.systemPackages = [ 
    pkgs.powertop 
    ];
}