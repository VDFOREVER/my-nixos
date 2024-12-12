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
            systemd-boot.enable = false;
            efi.canTouchEfiVariables = true;

            grub = {
                efiSupport = true;
                device = "nodev";
                useOSProber = true;
            };
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
    };
    
    time.timeZone = "Europe/Moscow";
    networking.hostName = "nixos";
    i18n.defaultLocale = "en_US.UTF-8";
    
    system.stateVersion = "24.05";
}

