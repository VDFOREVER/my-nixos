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
		terminus_font_ttf
		(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
	];
}
