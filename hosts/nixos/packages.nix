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
		(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
	];
}
