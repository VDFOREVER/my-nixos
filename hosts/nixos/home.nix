{
	imports = [
		../../modules/home
	];

	nixpkgs.config.allowUnfree = true;

	home = {
		username = "svd";
		homeDirectory = "/home/svd";
		stateVersion = "24.05";
	};
}
