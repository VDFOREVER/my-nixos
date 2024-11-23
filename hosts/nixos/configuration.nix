{ inputs, ... }: {
    imports = [
	    ../../modules/system/bundle.nix
	    ./packages.nix
	    ./hardware-configuration.nix
    ];

    time.timeZone = "Europe/Moscow";

    networking.hostName = "nixos";

    i18n.defaultLocale = "en_US.UTF-8";

    boot.tmp.useTmpfs = true;
    
    nix.settings.experimental-features = ["nix-command" "flakes"];
    system.stateVersion = "24.05";
}

