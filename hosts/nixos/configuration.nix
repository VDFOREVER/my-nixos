{ inputs, ... }: {
    imports = [
	    ../../modules/system
	    ./packages.nix
	    ./hardware-configuration.nix
    ];

    singbox.enable = true;
    amdgpu.enable = true;
    gc.enable = true;

    networking.dhcpcd.enable = true;
    services.gvfs.enable = true;

	boot = {
        tmp.useTmpfs = true;
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
	};

    programs = {
        gnupg.agent.enable = true;
        dconf.enable = true;
    };

    security = {
        polkit.enable = true;
        rtkit.enable = true;
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];
    
    time.timeZone = "Europe/Moscow";
    networking.hostName = "nixos";
    i18n.defaultLocale = "en_US.UTF-8";
    
    system.stateVersion = "24.05";
}

