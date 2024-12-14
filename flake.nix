{
	description = "sadfasfsaf";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		firefox-addons = {
			url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	
	outputs = { nixpkgs, home-manager, ... }@inputs:
		let 
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			nixosConfigurations = {
				nixos = nixpkgs.lib.nixosSystem { 
					inherit system;
					modules = [./hosts/nixos/configuration.nix];
				};

				notebook = nixpkgs.lib.nixosSystem {
					inherit system;
					modules = [./hosts/notebook/configuration.nix];
				};
			};

			homeConfigurations.svd = home-manager.lib.homeManagerConfiguration {	
				inherit pkgs;
				extraSpecialArgs = { inherit inputs; };
				modules = [./hosts/nixos/home.nix];
			};
		};
}
