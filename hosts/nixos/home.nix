{pkgs, ...}: {
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
		alacritty = true;
	};

	vscode = {
		enable = true;
		extensions = true;
	};

	firefox.enable = true;
	waybar.enable = true;
	theming.enable = true;
	git.enable = true;
	fish.enable = true;

    programs.gpg.enable = true;
    services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        pinentryPackage = pkgs.pinentry-gnome3;
    };
	
	home = {
		username = "svd";
		homeDirectory = "/home/svd";
		stateVersion = "24.05";
	};
}
