{ pkgs, ... }: {
	nixpkgs.config = {
		allowUnfree = true;
	};
	
	environment.systemPackages = with pkgs; [
		firefox
		telegram-desktop
		alacritty
		obs-studio
		mpv
		nemo		
		nekoray	
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
		libnotify

		mako
		xwayland
		wl-clipboard
		xwayland
		seatd
		hyprland
		wofi
		waybar
		hypridle
		hyprpaper
		hyprpicker
		hyprcursor
		hyprlock

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
