

{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
}
