{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./hardware-configuration.nix
    ./modules/languages.nix
    ./modules/packages.nix
    ./modules/slack.nix
    ./modules/teams.nix
    ./modules/hardware-dev.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelParams = [ "i915.enable_dpcd_backlight=3" ];

  networking.hostName = "rusmachine";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  security.rtkit.enable = true;

  services.cardwired = {
    enable = true;
    settings = {
      battery_auto_switch_mode = "integrated";
      experimental_nvidia_block = true;
    };
  };
  hardware.graphics.extraPackages = with pkgs; [intel-media-driver];
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;

    powerManagement = {
      enable = true;
      finegrained = true;
    };

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.blueman.enable = true;

  services.asusd.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        energy_performance_preference = "power";
        turbo = "never";
      };
      charger = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };

  services.udev.extraRules = ''
    KERNEL=="card*", KERNELS=="0000:00:02.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/intel-igpu"
    KERNEL=="card*", KERNELS=="0000:01:00.0", SUBSYSTEM=="drm", SUBSYSTEMS=="pci", SYMLINK+="dri/nvidia-dgpu"
  '';

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  users.users.ruslan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.getty.autologinUser = "ruslan";

  programs.bash.loginShellInit = ''
    if [[ "$(tty)" == "/dev/tty1" ]] && uwsm check may-start; then
      exec uwsm start -e -D Hyprland hyprland.desktop
    fi
  '';

  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  services.tailscale.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.waybar.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05"; # Did you read the comment?

}
