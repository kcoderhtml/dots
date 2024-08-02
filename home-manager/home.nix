# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    
    # spicetify
    inputs.spicetify-nix.homeManagerModules.default

    # catpuccin
    inputs.catppuccin.homeManagerModules.catppuccin

    # inputs.Hyprnix.homeManagerModules.hyprland

    ./hyprland.nix
    # ./hyprland

    ./waybar.nix

    ./neovim.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "kierank";
    homeDirectory = "/home/kierank";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # catppuccin
  catppuccin = {
    enable = true;
    accent = "green";
    flavor = "macchiato";
    pointerCursor = {
      enable = true;
      accent = "blue";
      flavor = "macchiato";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      tweaks = [ "normal" ];
    };
  };


  qt = {
    style.name = "kvantum";
    platformTheme.name = "kvantum";
    enable = true;
  };

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        udisks_version = 2;
        tray = false;
      };
      notifications = {
        device_unmounted = false;
        device_added = -1;
        device_removed = -1;
        device_mounted = -1;
      };
    };
  };

  # git config
  programs.git = {
    enable = true;
    userName = "Kieran Klukas";
    userEmail = "92754843+kcoderhtml@users.noreply.github.com";
    aliases = {
      c = "commit";
      p = "push";
    };
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowedSigners";
      user.signingKey = "~/.ssh/id_rsa.pub";
      pull.rebase = true;
    };
  };

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "macchiato";
    };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;
      
      # Change command timeout from 500 to 1000 ms
      command_timeout = 1000;
      
      format = lib.concatStrings [
        "\n"
        "$env_var"
        "$all$character"
      ];
      
      character = {
        success_symbol = "[](bold purple)";
        error_symbol = "[](bold red)";
      };
      
      username = {
        style_user = "green";
        style_root = "red";
        format = "[󱄅 $user]($style) ";
	      disabled = false;
        show_always = true;
      };
      
      hostname = {
        ssh_only = false;
        format = "on [$hostname](bold yellow) ";
        disabled = false;
      };

      directory = {
        truncation_length = 1;
        truncation_symbol = "…/";
        home_symbol = "  ~";
        read_only_style = "197";
        read_only = "  ";
        format = "at [$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        symbol = "󰊢 ";
        format = "via [$symbol$branch]($style) ";
        truncation_length = 6;
        truncation_symbol = "…/";
        style = "bold green";
      };

      git_status = {
         format = "[《$all_status$ahead_behind》]($style) ";
         style = "bold green";
         conflicted = " ";
         up_to_date = " ";
         untracked = " ";
         ahead = "⇡$count ";
         diverged = "⇡$ahead_count⇣$behind_count ";
         behind = "⇣$count ";
         stashed = "󱑿 ";
         modified = " ";
         staged = "[⟨++$count⟩ ](green)";
         renamed = "󱅄 ";
         deleted = " ";
       };

       docker_context = {
         symbol = " ";
         disabled = false;
       };

       python = {
         symbol = "󰌠 ";
         python_binary = "python3";
         disabled = false;
       };

       nodejs = {
         symbol = " ";
         detect_files = ["package.json" ".node-version" "!bunfig.toml" "!bun.lockb"];
         disabled = false;
       };

       bun = {
         symbol = "󰟈 ";
         disabled = false;
       };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
      update = "sudo nixos-rebuild switch";
      gc = "git commit";
      gp = "git push";
      rr = "rm -Rf";
      ghrpc = "gh repo create -c";
    };
    initExtra = ''
      #ssh auto reconnect
      assh() {
          local host=$1
          local port=$2
        while true; do
              ssh -p $port -o "BatchMode yes" $host || sleep 1
          done
      }
    '';
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "git" "command-not-found" "colored-man-pages" ];
    };

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        # will source zsh-sytax-highlighting
         name = "zsh-sytax-highlighting";
         src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
         sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  }; 

  # alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      live_config_reload = true;
      cursor = {
        unfocused_hollow = true;
        style = {
          blinking = "On";
        };
      };
      window = {
        opacity = 0.75;
        padding = {
          x = 12;
          y = 12;
        };
      };
      font = {
        size = 13;
        normal = {
          family = "JetBrainsMono Nerd Font";
        };        
      };
      colors = {
        primary = {
          background = lib.mkForce "#1E2128";
        };
      };
    };
  };

  services.mako = {
    enable = true;
    defaultTimeout = 4000;
    margin = "58,6";
    font = "Fira Sans 12";
    borderRadius = 5;
  };

  programs.tofi = {
    enable = true;
    catppuccin.enable = false;
    settings = {
      font = "Fira Sans";
      font-size = 24;

      prompt-text = ''">  "'';
      placeholder-text = "search for something";
      hide-cursor = true;

      corner-radius = 10;
      outline-width = 3;
      border-width = 0;
      padding-left = "4%";
      padding-top = "2%";
      padding-right = 0;
      padding-bottom = 0;

      outline-color = "#1E2030";
      text-color = "#cad3f5";
      prompt-color = "#ed8796";
      placeholder-color = "#8087A2";
      selection-color = "#eed49f";
      background-color = "#24273a";

      width = "35%";
      height = "15%";
    };
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace; [
      ms-vscode.live-server
      formulahendry.auto-rename-tag
      edwinkofler.vscode-assorted-languages
      golang.go
      catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
      eamodio.gitlens
      yzhang.markdown-all-in-one
      github.vscode-github-actions
      yoavbls.pretty-ts-errors
      esbenp.prettier-vscode
      vsciot-vscode.vscode-arduino
      ms-vscode.cpptools
      ms-vscode.vscode-serial-monitor
      prisma.prisma
      ms-azuretools.vscode-docker
    ];
    userSettings = {
      "editor.semanticHighlighting.enabled" = true;
      "terminal.integrated.minimumContrastRatio" = 1;
      "window.titleBarStyle" = "custom";

      "gopls" = {
        "ui.semanticTokens" = true;
      };
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "catppuccin.accentColor" = "blue";
      "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "git.autofetch" = true;
      "git.confirmSync" = false;
      "github.copilot.editor.enableAutoCompletions" = false;

      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
