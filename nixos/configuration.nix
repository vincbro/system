# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      vince = import ./home.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Docker
  virtualisation.docker = {
    enable = true;
  };

  # Configure hyprland
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # greetd
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.hyprland}/bin/hyprland";
        user = "vince";
      };
      default_session = initial_session;
    };
  };
  security.pam.services.greetd.enableGnomeKeyring = true;

  # keyring
  services.gnome.gnome-keyring.enable = true;

  # shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    # ohMyZsh = {
    #   enable = true;
    #   theme= "fishy";
    #   plugins = [ "git" ];
    # };
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/system/#orion";
    };
  };

  # programs.tmux = {
  #   enable = true;
  #   escapeTime = 0;
  #   shortcut = "SPACE";
  #   baseIndex = 1;
  #   keyMode = "vi";
  #   terminal = "screen-256color";
  #   extraConfig = ''
  #     bind -r ^ last-window
  #     bind -r k select-pane -U
  #     bind -r j select-pane -D
  #     bind -r h select-pane -L
  #     bind -r l select-pane -R

  #     set -g status-position top
  #     set -g status-justify centre
  #     set -g status-style 'fg=colour7 bg=default'

  #     # left: session name
  #     set -g status-left '#S'
  #     set -g status-left-style 'fg=colour4'
  #     set -g status-left-length 40

  #     # right: host name
  #     set -g status-right '#H'
  #     set -g status-right-style 'fg=colour4'
  #     set -g status-right-length 40

  #     # windows: plain text, subtle highlight on current
  #     setw -g window-status-format '#I:#W '
  #     setw -g window-status-current-format '#[fg=colour4]#I:#W '
  #     setw -g window-status-style 'fg=colour7'
  #     setw -g window-status-current-style 'fg=colour4'

  #     # pane borders (thin contrast)
  #     set -g pane-border-style 'fg=colour8'
  #     set -g pane-active-border-style 'fg=colour4'

  #   '';
  # };

  # Sound server
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  console.keyMap = "sv-latin1";

  users.users.vince = {
    isNormalUser = true;
    description = "Vincent Brodin";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      discord
      spotify
      zoom-us
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [
    pkgs.ghostty
    pkgs.google-chrome
    pkgs.home-manager
    pkgs.pcmanfm
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05"; # DO NOT CHANGE
}
