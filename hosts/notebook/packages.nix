{ pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;
	
	environment.systemPackages = with pkgs; [
		telegram-desktop
		alacritty
		obs-studio
		mpv
		nemo
		vscode
		pass
		steam
		prismlauncher
		file-roller
		transmission_4-gtk
		filezilla
		#wineWowPackages.waylandFull
		baobab
		brightnessctl
		
		python3
		
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
