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


  imports = [
    inputs.noctalia.homeModules.default
  ];
  programs.noctalia-shell.enable = true;

  programs.git = {
    enable = true;
    userName = "Vincent Brodin";
    userEmail = "vincent.brodin21@gmail.com";

    extraConfig = {
      credential = {
        helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
      };
    };
  };

  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519_personal";
      };

      "github-work" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519_work";
        identitiesOnly = true;
      };
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/vince/system";
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    shell = "${pkgs.zsh}/bin/zsh";
    prefix = "C-Space";
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    disableConfirmationPrompt = true;
    escapeTime = 0;

    terminal = "screen-256color";

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set -s copy-command 'wl-copy'

      set-option -g renumber-windows on
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-style "bg=default"
      set -g window-status-current-style "fg=black bg=white"
      set -g status-interval 5
      set -g status-left "#S"
      set -g status-right ""

      bind f display-popup -E "~/.dotfiles/scripts/tmux-session-dispensary.sh"
      bind o display-popup -E "~/.dotfiles/scripts/open-files.sh"
      bind g run "~/.dotfiles/scripts/open-github.sh"

      bind c new-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    '';
  };

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "Kanagawa-B-LB";
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

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
  };

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
    tmux
    opencode
    #NIX
    nil
    nixfmt
    #MARKDOWN
    markdown-oxide
    #DEV
    gh
    felix-fm
    #FONTS
    nerd-fonts.monaspace
    #ROFI
    rofi
    rofi-network-manager
    #GNOME
    gnome-calculator
    #TOOLS
    killall
    zip
    unzip
    pavucontrol
    rclone
    btop
    libsecret
    wrk
    jq
    fd
    skim
    lazygit
    gum
    kanshi
    fastfetch
    bruno
    dbeaver-bin
    wget
    moonlight-qt
    # ENV
    ironbar
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
