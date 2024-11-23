{ pkgs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};
	
	environment.systemPackages = with pkgs; [
		firefox
		telegram-desktop
		alacritty
		obs-studio
		wofi
		mpv
		cinnamon.nemo		
		nekoray	
		vscode
		pass
		steam
		prismlauncher
		gnome.file-roller
		
		gcc
		cmake
		openssl
		zlib
		opencv
		boost
		
		fastfetch
		wget
		git
		htop
		libnotify

		mako
		xwayland
		wl-clipboard
		xwayland
		seatd
		hyprland
		waybar
		hypridle
		hyprpaper
		hyprpicker
		hyprcursor

		pipewire

		amdvlk

		grim
		grimblast
		slurp
		swappy
		sing-box
		pavucontrol
		jq # waybar weather
		home-manager
	];

	fonts.packages = with pkgs; [
		jetbrains-mono
		noto-fonts
		noto-fonts-emoji
		(nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
	];
}
