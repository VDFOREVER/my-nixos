{
	imports = [
		../../modules/home
	];

	nixpkgs.config.allowUnfree = true;

	hyprland = {
		enable = true;
		hyprpaper = true;
		hyprlock = true;
		hypridle = true;
		wofi = true;
		mako = true;
	};

	vscode = {
		enable = true;
		extensions = true;
	};

	firefox.enable = true;
	waybar.enable = true;
	theming.enable = true;
	git.enable = true;

	home = {
		username = "svd";
		homeDirectory = "/home/svd";
		stateVersion = "24.05";
	};
}
