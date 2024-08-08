{ self, config, lib, pkgs, inputs, ... }: {
  imports = [
    ./hypridle.nix
    ./waybar.nix
  ];

  # catppuccin theme shared between hyprlock and hyprland itself
  xdg.configFile."hypr/macchiato.conf".source = ../../dots/macchiato.conf;

  # hyprland config
  xdg.configFile."hypr/hyprland.conf".source = ../../dots/hyprland.conf;

  # hyprlock config
  xdg.configFile."hypr/hyprlock.conf".source = ../../dots/hyprlock.conf;
  xdg.configFile."face.png".source = ../../dots/face.png;
  programs.hyprlock.enable = true;

  # sunpaper
  xdg.configFile."sunpaper/config".source = ../../dots/sunpaperconfig;
  xdg.configFile."sunpaper/images/".source = "${pkgs.sunpaper}/share/sunpaper/images";

  # portal
  xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  };
}
