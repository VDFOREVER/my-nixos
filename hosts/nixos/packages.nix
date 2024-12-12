{ pkgs, ... }: {
	nixpkgs.config.allowUnfree = true;
	
	environment.systemPackages = with pkgs; [
		firefox
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
		wineWowPackages.waylandFull
		baobab
		
		python3
		
		fastfetch
		wget
		git
		htop

		pavucontrol
		sing-box

		home-manager
	];

	fonts.packages = with pkgs; [
		jetbrains-mono
		noto-fonts
		noto-fonts-emoji
		nerd-fonts.symbols-only
	];
}
