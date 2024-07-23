# Kieran's Dots

> [!CAUTION]
> These dots are highly prone to change / breakage. I am not a nix os expert (this is my first time touching nix), so I'm not sure if this will work or not. I'm just trying to get my dots up on github. If you have any suggestions, please let me know.

## Installation

~~I have absolutely no idea~~ I kinda understand now?

1. Install NixOS via the [official guide](https://nixos.org/download.html)
2. `sudo -i`
3. Enable git with `sed -i 's/^{$/{\n  programs.git.enable = true;/' /etc/nixos/configuration.nix` and then run `nixos-rebuild switch`
4. Clone this repo to your `/root/dots` folder with `git clone https://github.com/kcoderhtml/dots.git`
5. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /dots/moonlark/disk-config.nix`
6. `nixos-install --flake .#moonlark`

## Screenshots

🫡 Will report back!

## Credits

Thanks a bunch to the following people for their dots, configs, and general inspiration which i've shamelessly stolen from:

- [NixOS/nixos-hardware](https://github.com/NixOS/nixos-hardware)
- [hyprland-community/hyprnix](https://github.com/hyprland-community/hyprnix)
- [spikespaz/dotfiles](https://github.com/spikespaz/dotfiles)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [mccd.space install guide](https://mccd.space/posts/git-to-deploy/)