{ inputs, pkgs, ... }: {
    imports = [
	    ../../modules/system
	    ./packages.nix
	    ./hardware-configuration.nix
    ];

    singbox.enable = true;
    amdgpu.enable = true;
    gc.enable = true;
    vm.enable = true;
    yggdrasil.enable = true;

    networking.dhcpcd.enable = true;
    zramSwap.enable = true;
    documentation.nixos.enable = false;

    programs.fish.enable = true;
	users = {
		defaultUserShell = pkgs.fish;
		users.svd = {
			isNormalUser = true;
			extraGroups = ["wheel" "input"];
		};
	};

    services = {
        earlyoom.enable = true;
        gvfs.enable = true;
        gnome.gnome-keyring.enable = true;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
	    };
    };

    systemd = {
        coredump.enable = false;
        oomd.enable = false;
    };

	boot = {
        kernelPackages = pkgs.linuxPackages_latest;
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
        substituters = ["https://hyprland.cachix.org"];
		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    time.timeZone = "Europe/Moscow";
    networking.hostName = "nixos";
    i18n.defaultLocale = "en_US.UTF-8";
    
    system.stateVersion = "24.05";
}

