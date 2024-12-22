{
  description = "A simple NixOS flake with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, aagl, ... } @inputs:
  let
    commonModules = { username, hostFile, userHome }: [
      hostFile
      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit nixpkgs home-manager plasma-manager aagl; };
        home-manager.users.${username} = import userHome;
      }
    ];
  in
  {
    nixosConfigurations = {
      "nixos-test" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules {
          username = "cak";
          hostFile = ./hosts/nixos-test;
          userHome = ./users/cak/home.nix;
        };
      };
      "840-g6" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules {
          username = "cak";
          hostFile = ./hosts/840-g6;
          userHome = ./users/cak/home.nix;
        };
      };
      "desktop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules {
          username = "cak";
          hostFile = ./hosts/desktop;
          userHome = ./users/cak/home.nix;
        } ++ [
          aagl.nixosModules.default
        ];
      };
    };
  };
}
