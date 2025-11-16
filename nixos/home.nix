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
  };
  programs.waybar.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    # HELIX
    helix
    nil
    nixfmt-rfc-style
    # RUST
    rustc
    cargo
    rustfmt
    rust-analyzer
    # DEV
    pkg-config
    openssl
    gcc
    gh
    #FONTS
    nerd-fonts.fira-mono
    nerd-fonts.fira-code
    # MISC
    rofi
    rose-pine-hyprcursor
    hyprpaper
    zoxide
    wl-clipboard
    fastfetch
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
