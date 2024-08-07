{ lib, ... }:
{
  wayland.windowManager.hyprland = {
    # <https://wiki.hyprland.org/Configuring/Variables/#general>
    config.general = {
      border_size = 2;
      gaps_inside = 5;
      gaps_outside = 10;
      resize_on_border = true;
      extend_border_grab_area = 10;
    };

    # <https://wiki.hyprland.org/Configuring/Variables/#decoration>
    config.decoration = {
      rounding = 0;
      shadow_range = 8;
      shadow_render_power = 2;
      blur = {
        size = 3; # 8
        passes = 2; # 1
        ignore_opacity = true; # false
        xray = true; # false
        noise = 6.5e-2; # 0.0117
        contrast = 0.75; # 0.8916
        brightness = 0.8; # 0.8172
      };
    };

    # <https://wiki.hyprland.org/Configuring/Variables/#input>
    config.input = let
      DISABLED = 0;
      LOOSE = 2;
    in {
      follow_mouse = LOOSE;
      float_switch_override_focus = DISABLED;
      touchpad = {
        natural_scroll = true;
      };
    };

    # <https://wiki.hyprland.org/Configuring/Variables/#binds>
    config.binds = let LONGEST_SHARED_SIDE = 1;
    in {
      pass_mouse_when_bound = false;
      focus_preferred_method = LONGEST_SHARED_SIDE;
    };

    config.gestures = {
      workspace_swipe = {
        enable = true;
        invert = false;
        min_speed_to_force = 20;
        cancel_ratio = 0.65;
        create_new = false;
        forever = true;
      };
    };

    # <https://wiki.hyprland.org/Configuring/Variables/#misc>
    config.misc = let FULLSCREEN_ONLY = 2;
    in {
      disable_hyprland_logo = true; # false
      disable_splash_rendering = true; # false
      force_default_wallpaper = 0; # disable weeb stuff
      variable_framerate = true;
      variable_refresh = FULLSCREEN_ONLY;
      disable_autoreload = true; # false # nix takes care of that

      # works well with swayidle
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
    };

    config.group = {
      insert_after_current = true;
      focus_removed_window = true;

      # These features are not polished yet:
      # <https://github.com/hyprwm/Hyprland/issues/2415>
      # @MightyPlaza is working on this, but not doing it how we expect.
      # <https://github.com/hyprwm/Hyprland/pull/3197>
      groupbar = rec {
        font_size = 9;
        gradients = false;
        render_titles = true;
        scrolling = true;
      };
    };

    # <https://wiki.hyprland.org/Configuring/Dwindle-Layout/>
    config.dwindle = let ALWAYS_EAST = 2;
    in {
      force_split = ALWAYS_EAST; # 0
      preserve_split = true; # false
      # no_gaps_when_only = true;
    };

    # <https://wiki.hyprland.org/Configuring/Animations/#curves>
  };
}