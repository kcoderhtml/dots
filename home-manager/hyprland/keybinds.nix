# Converted with regex from hyprland config
# search: ^(\s*)(bind[rwelm]*) = (|\w+), (|\$?\w+), (.+)$ /gm
# replace: $1$2."$3, $4" = "$5";

{ config, pkgs, lib, ... }: {
  # <https://wiki.hyprland.org/Configuring/Dispatchers/>
  wayland.windowManager.hyprland.keyBinds = let
    MOUSE_LMB = "mouse:272";
    MOUSE_RMB = "mouse:273";
    # MOUSE_MMB = "mouse:274";
    MOUSE_EX1 = "mouse:275";
    MOUSE_EX2 = "mouse:276";

    # Collections of keybinds common across multiple submaps are collected into
    # groups, which can be merged together granularly.
    groups = {
      # Exit the submap and restore normal binds.
      submapReset = {
        bind.", escape" = "submap, reset";
        bind."CTRL, C" = "submap, reset";
      };

      # Self-explanatory.
      launchPrograms = {
        # Launch the program with a shortcut.
        bind."SUPER, E" = "exec, dolphin";
        bind."SUPER, Enter" = "exec, foot";
      };

      # Kill the active window.
      killWindow = { bind."SUPER, Q" = "killactive,"; };

      # Either window focus or window movement.
      moveFocusOrWindow = with groups;
        lib.mkMerge [ moveFocus moveWindow mouseMoveWindow ];

      # Focus on another window, in the specified direction.
      moveFocus = {
        bind."SUPER, left" = "movefocus, l";
        bind."SUPER, right" = "movefocus, r";
        bind."SUPER, up" = "movefocus, u";
        bind."SUPER, down" = "movefocus, d";
      };

      # Swap the active window with another, in the specified direction.
      moveWindow = {
        bind."SUPER_SHIFT, left" = "movewindow, l";
        bind."SUPER_SHIFT, right" = "movewindow, r";
        bind."SUPER_SHIFT, up" = "movewindow, u";
        bind."SUPER_SHIFT, down" = "movewindow, d";
      };

      # Translate the dragged window by mouse movement.
      mouseMoveWindow = {
        bindm."SUPER, ${MOUSE_LMB}" = "movewindow";
        bindm.", ${MOUSE_EX2}" = "movewindow";
      };

      # Toggle between vertical and horizontal split for
      # the active window and an adjacent one.
      toggleSplit = { bind."SUPER, tab" = "togglesplit,"; };

      # Resize a window with the mouse.
      mouseResizeWindow = {
        bindm."SUPER, ${MOUSE_RMB}" = "resizewindow";
        bindm.", ${MOUSE_EX1}" = "resizewindow";
      };

      # Switch to the next/previous tab in the active group.
      changeGroupActive = {
        bind."ALT, tab" = "changegroupactive, f";
        bind."ALT, grave" = "changegroupactive, b";
      };

      # Switch to another workspace.
      switchWorkspace = with groups;
        lib.mkMerge [ switchWorkspaceAbsolute switchWorkspaceRelative ];

      # Switch to a workspace by absolute identifier.
      switchWorkspaceAbsolute = {
        # Switch to a primary workspace by index.
        bind."SUPER, 1" = "workspace, 1";
        bind."SUPER, 2" = "workspace, 2";
        bind."SUPER, 3" = "workspace, 3";
        bind."SUPER, 4" = "workspace, 4";
        bind."SUPER, 5" = "workspace, 5";
        bind."SUPER, 6" = "workspace, 6";
        bind."SUPER, 7" = "workspace, 7";
        bind."SUPER, 8" = "workspace, 8";
        bind."SUPER, 9" = "workspace, 9";
        bind."SUPER, 0" = "workspace, 10";

        # Switch to an alternate workspace by index.
        bind."SUPER_ALT, 1" = "workspace, 11";
        bind."SUPER_ALT, 2" = "workspace, 12";
        bind."SUPER_ALT, 3" = "workspace, 13";
        bind."SUPER_ALT, 4" = "workspace, 14";
        bind."SUPER_ALT, 5" = "workspace, 15";
        bind."SUPER_ALT, 6" = "workspace, 16";
        bind."SUPER_ALT, 7" = "workspace, 17";
        bind."SUPER_ALT, 8" = "workspace, 18";
        bind."SUPER_ALT, 9" = "workspace, 19";
        bind."SUPER_ALT, 0" = "workspace, 20";

        # TODO Bind the special workspace to `XF86Favorites`.
        # TODO Create a bind for "insert after current workspace".
      };

      # Switch to workspaces relative to the current one.
      switchWorkspaceRelative = {
        # Switch to the next/previous used workspace with page keys.
        bind."SUPER, page_down" = "workspace, m+1";
        bind."SUPER, page_up" = "workspace, m-1";

        # Switch to the next/previous used workspace
        # with the right and left square brackets,
        # while holding super and shift.
        bind."SUPER, bracketright " = "workspace, m+1";
        bind."SUPER, bracketleft" = "workspace, m-1";

        # Switch to the next/previous used workspace with the mouse wheel.
        bind."SUPER, mouse_up" = "workspace, m+1";
        bind."SUPER, mouse_down" = "workspace, m-1";
      };

      # Send a window to another workspace.
      sendWindow = with groups;
        lib.mkMerge [ sendWindowAbsolute sendWindowRelative ];

      # Send a window to a workspace by absolute identifier.
      sendWindowAbsolute = {
        # Move the active window or group to a primary workspace by index.
        bind."SUPER_SHIFT, 1" = "movetoworkspacesilent, 1";
        bind."SUPER_SHIFT, 2" = "movetoworkspacesilent, 2";
        bind."SUPER_SHIFT, 3" = "movetoworkspacesilent, 3";
        bind."SUPER_SHIFT, 4" = "movetoworkspacesilent, 4";
        bind."SUPER_SHIFT, 5" = "movetoworkspacesilent, 5";
        bind."SUPER_SHIFT, 6" = "movetoworkspacesilent, 6";
        bind."SUPER_SHIFT, 7" = "movetoworkspacesilent, 7";
        bind."SUPER_SHIFT, 8" = "movetoworkspacesilent, 8";
        bind."SUPER_SHIFT, 9" = "movetoworkspacesilent, 9";
        bind."SUPER_SHIFT, 0" = "movetoworkspacesilent, 10";

        # Move the active window or group to an alternate workspace by index.
        bind."SUPER_ALT_SHIFT, 1" = "movetoworkspacesilent, 11";
        bind."SUPER_ALT_SHIFT, 2" = "movetoworkspacesilent, 12";
        bind."SUPER_ALT_SHIFT, 3" = "movetoworkspacesilent, 13";
        bind."SUPER_ALT_SHIFT, 4" = "movetoworkspacesilent, 14";
        bind."SUPER_ALT_SHIFT, 5" = "movetoworkspacesilent, 15";
        bind."SUPER_ALT_SHIFT, 6" = "movetoworkspacesilent, 16";
        bind."SUPER_ALT_SHIFT, 7" = "movetoworkspacesilent, 17";
        bind."SUPER_ALT_SHIFT, 8" = "movetoworkspacesilent, 18";
        bind."SUPER_ALT_SHIFT, 9" = "movetoworkspacesilent, 19";
        bind."SUPER_ALT_SHIFT, 0" = "movetoworkspacesilent, 20";
      };

      # Send windows to other workspaces, relative to the current one.
      sendWindowRelative = {
        # Move the active window or group to the next/previous
        # workspace with page keys, while holding super and shift.
        bind."SUPER_SHIFT, page_down" = "movetoworkspace, r+1";
        bind."SUPER_SHIFT, page_up" = "movetoworkspace, r-1";

        # Move the active window or group to the next/previous
        # workspace with the right and left square brackets,
        # while holding super and shift.
        bind."SUPER_SHIFT, bracketright" = "movetoworkspace, r+1";
        bind."SUPER_SHIFT, bracketleft" = "movetoworkspace, r-1";

        # Move the active window or group to the next/previous
        # workspace with the mouse wheel while holding super and shift.
        bind."SUPER_SHIFT, mouse_up" = "movetoworkspace, r+1";
        bind."SUPER_SHIFT, mouse_down" = "movetoworkspace, r-1";
      };
    };
  in lib.mkMerge [
    ### ACTIVE WINDOW ACTIONS ###
    groups.killWindow
    {
      # Toggle full-screen for the active window.
      bind."SUPER_SHIFT, F" = "fullscreen, 0";

      # Float/unfloat the active window.
      bind."SUPER, F" = "togglefloating,";
    }
    ### MISCELLANEOUS ###
    {
      # Lock the session immediately.
      bind."SUPER, l" = "exec, loginctl lock-session";

      # Kill the window manager.
      bind."SUPER_SHIFT, M" = "exit,";

      # Forcefully kill a program after selecting its window with the mouse.
      bind."SUPER_SHIFT, Q" = "exec, hyprctl kill";

      # Select a region and take a screenshot, saving to the clipboard.
      bind."SUPER_SHIFT, print" = "exec, prtsc -c -m r -D -b 00000066";

      # Bypass all binds for the window manager and pass key combinations
      # directly to the active window.
      bind."SUPER_SHIFT, K" = "submap, passthru";
      submap.passthru = { bind."SUPER_SHIFT, K" = "submap, reset"; };
    }
    ### PROGRAM LAUNCHING ###
    groups.launchPrograms
    {
      # Open Rofi to launch a program.
      bind."SUPER, Space" = "exec, rofi -show drun -show-icons";
      # Open Rofi to run a command.
      bind."SUPER, R" = "exec, rofi -show run";
    }
    ### WINDOW FOCUS & MOVEMENT ###
    groups.moveFocusOrWindow
    ### WINDOW RESIZING ###
    groups.toggleSplit
    groups.mouseResizeWindow
    
    ### WORKSPACE SWITCHING ###
    groups.switchWorkspace
    ### WORKSPACE WINDOW MOVEMENT ###
    groups.sendWindow
  ];
}
