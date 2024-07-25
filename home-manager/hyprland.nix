{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  xdg.configFile."sunpaper/config".source = ./dots/sunpaperconfig;
  xdg.configFile."hypr/hyprland.conf".source = ./dots/hyprland.conf;
}
