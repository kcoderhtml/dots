{
  description = "Kieran's opinionated (and probably slightly dumb) nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS hardware configuration
    hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland nix
    Hyprnix.url = "github:hyprland-community/hyprnix";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
    };

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    
    # agenix
    agenix.url = "github:ryantm/agenix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # catppuccin
    catppuccin.url = "github:catppuccin/nix";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    agenix,
    home-manager,
    nixos-hardware,
    hyprland-contrib,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    unstable-overlays = {
      nixpkgs.overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        })
      ];
    };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      moonlark = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {inherit inputs outputs;};

        # > Our main nixos configuration file <
        modules = [
          inputs.disko.nixosModules.disko
          { disko.devices.disk.disk1.device = "/dev/vda"; }
          agenix.nixosModules.default
          ./moonlark/configuration.nix
          unstable-overlays
        ];
      };
    };
  };
}
