# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.systemd-boot.consoleMode = "max";
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.initrd.systemd.enable = true;
  boot.loader.timeout = null;
  boot.plymouth.enable = true;
  
  # less verbose boot log
  boot.consoleLogLevel = 3;
  boot.kernelParams = [ "quiet" "udev.log_priority=3" ];
  
  powerManagement.enable = true;

  hardware.cpu.amd.updateMicrocode = true;

  # AMD GPU stuff
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  # laptop stuff
  hardware.sensor.iio.enable = true;
  
  networking.hostName = "bryce-laptop"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  
  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    epiphany # web browser
    geary # email reader
    gnome-characters
    gnome-software
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    excludePackages = [ pkgs.xterm ];
  };
  
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # docker
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bryce = {
    isNormalUser = true;
    description = "bryce";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # PackageKit
  services.packagekit.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    gparted
    git
    wget
    curl
    nodejs
    unrar
    wine
    winetricks
    inputs.nix-software-center.packages.${system}.nix-software-center
    papirus-icon-theme
    virt-manager
    cifs-utils
    docker-compose
    appimage-run
    gnomeExtensions.appindicator
    gnome-extension-manager
    gnome.gnome-tweaks
    usbutils
    steam-run
  ];
  
  services.flatpak.enable = true;
  services.ratbagd.enable = true;
  
#  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto system update
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = "https://channels.nixos.org/nixos-unstable";
  };

  system.stateVersion = "23.05"; # Did you read the comment?

}
