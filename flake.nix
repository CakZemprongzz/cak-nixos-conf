{
  description = "McCak NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, plasma-manager, aagl,lix-module, ... } @ inputs:
  let
    makeConfig = { name, username, hostFile, extraModules ? [] }: nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        lix-module.nixosModules.default
        hostFile
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.${username} = import ./users/${username}/home.nix;
        }
      ] ++ extraModules;
    };
  in
  {
    nixosConfigurations = {
      "nixos-test" = makeConfig { 
        name = "nixos-test"; 
        username = "cak"; 
        hostFile = ./hosts/nixos-test; 
      };
      "840-g6" = makeConfig { 
        name = "840-g6"; 
        username = "cak"; 
        hostFile = ./hosts/840-g6; 
      };
      "desktop" = makeConfig { 
        name = "desktop"; 
        username = "cak"; 
        hostFile = ./hosts/desktop; 
        extraModules = [ aagl.nixosModules.default ]; 
      };
      "delta" = makeConfig { 
        name = "delta"; 
        username = "cak"; 
        hostFile = ./hosts/delta; 
      };
    };
  };
}
