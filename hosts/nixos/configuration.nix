{ inputs, pkgs, ... }: {
    imports = [
	    ../../modules/system
	    ./packages.nix
	    ./hardware-configuration.nix
    ];

    singbox.enable = true;
    amdgpu.enable = true;
    gc.enable = true;

    networking.dhcpcd.enable = true;
    zramSwap.enable = true;
    documentation.nixos.enable = false;
    
    services = {
        earlyoom.enable = true;
        gvfs.enable = true;
    };

    systemd = {
        coredump.enable = false;
        oomd.enable = false;
    };

	boot = {
        tmp.useTmpfs = true;
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
	};

    programs = {
        nix-ld.enable = true;
        gnupg.agent.enable = true;
        dconf.enable = true;
    };

    security = {
        polkit.enable = true;
        rtkit.enable = true;
    };

    nix.settings = {
        auto-optimise-store = true;
        experimental-features = ["nix-command" "flakes"];
        substituters = ["https://hyprland.cachix.org"];
		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    
    time.timeZone = "Europe/Moscow";
    networking.hostName = "nixos";
    i18n.defaultLocale = "en_US.UTF-8";
    
    system.stateVersion = "24.05";
}

