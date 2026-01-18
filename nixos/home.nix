{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "vince";
  home.homeDirectory = "/home/vince";

  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "Vincent Brodin";
      email = "vincent.brodin21@gmail.com";
    };
    extraConfig = {
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
    };
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "Kanagawa-BL";
      package = pkgs.kanagawa-gtk-theme;
    };
    iconTheme = {
      name = "Kanagawa";
      package = pkgs.kanagawa-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;

  programs.waybar.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    #HELIX
    helix
    wl-clipboard
    #ZED
    zed-editor
    #NIX
    nil
    nixfmt-rfc-style
    #MARKDOWN
    markdown-oxide
    #DEV
    pkg-config
    openssl
    gcc
    gh
    #FONTS
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
    #ROFI
    rofi
    rofi-network-manager
    rofi-bluetooth
    #GNOME
    gnome-bluetooth
    gnome-calculator
    gnome-tweaks
    #TOOLS
    killall
    zip
    unzip
    pavucontrol
    rclone
    btop
    libsecret
    #HYPR
    hyprpaper
    hyprshot
    rose-pine-hyprcursor
    #VM
    quickemu
    quickgui
    #MISC
    fastfetch
    bruno
    gemini-cli
    zellij
    wget
    openhue-cli
  ];

  fonts = {
    fontconfig.enable = true;
  };

  home.file = {
  };

  home.sessionVariables = {
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # DO NOT CHANGE
}
