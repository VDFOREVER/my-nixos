{ pkgs, inputs, ... }: {
	nixpkgs.config.allowUnfree = true;

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
		kdePackages.kdenlive

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
		(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
	];
}
