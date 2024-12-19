{
  description = "A simple NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    # Define reusable arguments for nixosSystem
    commonModules = { username, hostFile, userHome }: [
      hostFile
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit nixpkgs home-manager; };
        home-manager.users.${username} = import userHome;
      }
    ];
  in
  {
    nixosConfigurations = {
      # Configuration for nixos-test
      nixos-test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules {
          username = "cak";
          hostFile = ./hosts/nixos-test;
          userHome = ./users/cak/home.nix;
        };
      };

      # Configuration for 840-g6
      840-g6 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules {
          username = "cak";
          hostFile = ./hosts/840-g6;
          userHome = ./users/cak/home.nix;
        };
      };
    };
  };
}
