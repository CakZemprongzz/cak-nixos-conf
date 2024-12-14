{
  description = "A simple NixOS flake";
  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
      home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
 };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      nixos-test = let
        username = "mccak";
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/nixos-test
            #./users/${username}/nixos.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs;
              home-manager.users.mccak= import ./users/mccak/home.nix;
            }
          ];
        };
    };
  };
}
