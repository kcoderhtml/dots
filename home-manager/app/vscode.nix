{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # vscode config
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace; [
      ms-vscode.live-server
      formulahendry.auto-rename-tag
      edwinkofler.vscode-assorted-languages
      golang.go
      catppuccin.catppuccin-vsc-icons
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
      astro-build.astro-vscode
      github.copilot
      github.copilot-chat
      dotjoshjohnson.xml
      johnpapa.vscode-cloak
      mikestead.dotenv
      bradlc.vscode-tailwindcss
      mechatroner.rainbow-csv
    ]
    ++ [(pkgs.catppuccin-vsc.override {
      accent = "blue";
    })]; 

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
      
      "editor.formatOnSave" = true;

      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "editor.linkedEditing" = true;
    };
  };
}
