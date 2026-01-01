{
  config,
  pkgs,
  inputs,
  ...
}:

{

  home.username = "vince";
  home.homeDirectory = "/home/vince";

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
    #MISC
    rofi
    rofi-network-manager
    rofi-bluetooth
    rose-pine-hyprcursor
    hyprpaper
    fastfetch
    libsecret
    btop
    killall
    zip
    unzip
    gnome-bluetooth
    pavucontrol
    rclone
    hyprshot
    bruno
    gemini-cli
    zellij
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
