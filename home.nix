{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bryce";
  home.homeDirectory = "/home/bryce";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; ([
    prismlauncher
    discord
    calibre
    joplin-desktop
    write_stylus
    vlc
    lutris
    firefox
    thunderbird
    vscode-fhs
    signal-desktop
    qbittorrent
    libreoffice
    piper
    vlc
    gimp
    goverlay
    mangohud
    steam
    spotify
    python3
    sqlitebrowser
    nextcloud-client
    godot_4
  ]);

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  
  programs.git = {
    enable = true;
    userName = "bryce";
    userEmail = "bryce.hoehn@mailbox.org";
  };

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      disable-while-typing = false;
    };

    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

}
