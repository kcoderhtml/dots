

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
    catppuccin.flavor = "mocha";
    settings = {
      general.live_config_reload = true;
      cursor = {
        unfocused_hollow = true;
        style = {
          blinking = "On";
        };
      };
      window = {
        opacity = 0.88;
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
    };
  };
}
