{
    description = "NixOS configuration of vdforever";

    nixConfig = {
        extra-substituters = ["https://nix-community.cachix.org"];
        extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@ { self, nixpkgs, home-manager, ... }: {
        nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            modules = [
                ./hosts/pc

                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;

                    home-manager.extraSpecialArgs = inputs;
                    home-manager.users.vdforever = import ./home;
                }
            ];
        };
    };
  };
}