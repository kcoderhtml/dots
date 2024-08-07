{ self, config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.hyprnix.homeManagerModules.hyprland
    ./config.nix
    ./windowrules.nix
    ./keybinds.nix
    ../waybar.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    reloadConfig = true;
    systemdIntegration = true;
    recommendedEnvironment = true;

    fufexan.enable = true;

    xwayland.enable = true;

    config.exec_once = [
      # polkit agent, raises to root access with gui
      "${lib.getExe pkgs.lxqt.lxqt-policykit}"
      # allow apps with risen perms after agent to connect to local xwayland
      "${lib.getExe pkgs.xorg.xhost} +local:"
    ];
  };
}
