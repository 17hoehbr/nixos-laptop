{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-software-center.url = "github:vlinkz/nix-software-center";
    pia.url = "git+https://git.sr.ht/~rprospero/nixos-pia?ref=development";
    pia.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, pia, ... }: {
    nixosConfigurations = {
      bryce-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          pia.nixosModule
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bryce = import ./home.nix;
          }
        ];
        
        specialArgs = {
        # Make flake inputs available in NixOS modules.
          inherit inputs;
        };
      };
    };
  };
}
