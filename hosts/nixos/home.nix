{
	imports = [
		../../modules/home/bundle.nix
	];

	nixpkgs.config = {
    	allowUnfree = true;
    	allowUnfreePredicate = (_: true);
  	};

	home = {
		username = "svd";
		homeDirectory = "/home/svd";
		stateVersion = "24.05";
	};
}
