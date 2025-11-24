{ config, pkgs, ... }:

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
  programs.waybar.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    # HELIX
    helix
    wl-clipboard
    # NIX
    nil
    nixfmt-rfc-style
    # MARKDOWN
    markdown-oxide
    # DEV
    pkg-config
    openssl
    gcc
    gh
    zoxide
    #FONTS
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    jetbrains-mono
    # MISC
    rofi
    rose-pine-hyprcursor
    hyprpaper
    fastfetch
    libsecret
    killall
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
