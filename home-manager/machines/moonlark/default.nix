{ self, config, lib, pkgs, inputs, ... }: {
  imports = [
    # window manager
    ../../wm/hyprland

    # shell
    ../../app/shell.nix

    # apps
    ../../app/neovim.nix
    ../../app/git.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.catppuccin-vsc.overlays.default
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


  ###########
  # theming #
  ###########

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
}
