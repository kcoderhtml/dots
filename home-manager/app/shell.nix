{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
      # hackatime summary
      summary() {
        local user_id=$1
        curl -X 'GET' \
          "https://waka.hackclub.com/api/summary?user=''${user_id}&interval=high_seas" \
          -H 'accept: application/json' \
          -H 'Authorization: Bearer 2ce9e698-8a16-46f0-b49a-ac121bcfd608' | jq '. + {
            "total_categories_sum": (.categories | map(.total) | add),
            "total_categories_human_readable": (
                (.categories | map(.total) | add) as $total_seconds |
                "\($total_seconds / 3600 | floor)h \(($total_seconds % 3600) / 60 | floor)m \($total_seconds % 60)s"
            )
        }'
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
}
