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

		hyprland = {
			type = "git";
			url = "https://github.com/hyprwm/Hyprland";
			submodules = true;
		};
	};
	
	outputs = { nixpkgs, home-manager, hyprland, ... }@inputs:
		let 
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			nixosConfigurations = {
				nixos = nixpkgs.lib.nixosSystem { 
					specialArgs = {inherit inputs system;};
					modules = [./hosts/nixos/configuration.nix];
				};

				notebook = nixpkgs.lib.nixosSystem {
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
