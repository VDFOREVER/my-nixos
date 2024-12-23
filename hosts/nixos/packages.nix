{ pkgs, inputs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
		permittedInsecurePackages = [
			"olm-3.2.16"
		];	
	};

	environment.systemPackages = with pkgs; [
		telegram-desktop
		alacritty
		obs-studio
		mpv
		nemo
		pass
		steam
		prismlauncher
		file-roller
		transmission_4-gtk
		filezilla
		wineWowPackages.waylandFull
		baobab
		vscode
		nheko

		fastfetch
		wget
		git
		htop

		pavucontrol
		home-manager
	];

	fonts.packages = with pkgs; [
		jetbrains-mono
		noto-fonts
		noto-fonts-emoji
		nerd-fonts.symbols-only
	];
}
