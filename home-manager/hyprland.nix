{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  xdg.configFile."sunpaper/config".source = ./dots/sunpaperconfig;
  xdg.configFile."hypr/hyprland.conf".source = ./dots/hyprland.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./dots/hyprlock.conf;
  xdg.configFile."hypr/macchiato.conf".source = ./dots/macchiato.conf;
  xdg.configFile."face.png".source = ./dots/face.png;

  programs.hyprlock.enable = true;
  services.hypridle = {
    enable =  true;
    settings= {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "hyprlock";
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
      };

      listener = [
        {
          timeout = 30;
          on-timeout = "kill $(pidof wluma); brightnessctl -s set 10";
          on-resume = "brightnessctl -r; wluma &";
        }
        {
          timeout = 45;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 105;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
