# Kieran's Dots

> [!CAUTION]
> These dots are highly prone to change / breakage. I am not a nix os expert (this is my first time touching nix), so I'm not sure if this will work or not. I'm just trying to get my dots up on github. If you have any suggestions, please let me know.

## Installation

~~I have absolutely no idea~~ I kinda understand now?

1. Install NixOS via the [official guide](https://nixos.org/download.html)
2. `sudo -i`
3. Enable git with `sed -i 's/^{$/{\n  programs.git.enable = true;/' /etc/nixos/configuration.nix` and then run `nixos-rebuild switch`
4. Download the disk config with `curl https://github.com/kcoderhtml/dots/raw/master/moonlark/disk-config.nix -o /tmp/disk-config.nix`
5. Run disko with `nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disk-config.nix`
6. Mount disk with `mount | grep /mnt` and then `cd /mnt/etc/nixos`
7. Clone this repo to your `/mnt/etc/nixos` folder with `git clone https://github.com/kcoderhtml/dots.git .`
8. install the flake: `nixos-install --flake .#moonlark --no-root-passwd`
9. Once it finishes run nix install and then reboot
```bash
nixos-install
reboot
```
10. Pray to the nix gods that it works 🙏
11. If it worked then you should be able to login with the user `kierank` and the password `lolzthisaintsecure!`
12. Change the password with `passwd kierank`

## Screenshots

🫡 Will report back!

## Credits

Thanks a bunch to the following people for their dots, configs, and general inspiration which i've shamelessly stolen from:

- [NixOS/nixos-hardware](https://github.com/NixOS/nixos-hardware)
- [hyprland-community/hyprnix](https://github.com/hyprland-community/hyprnix)
- [spikespaz/dotfiles](https://github.com/spikespaz/dotfiles)
- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [mccd.space install guide](https://mccd.space/posts/git-to-deploy/)
- [disco docs](https://github.com/nix-community/disko/blob/master/docs/quickstart.md)