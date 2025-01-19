{ inputs, pkgs, ... }: 
let
    user = "svd";
    passHash = "$6$rEdBusDJyC3879uu$56M4FJdE5tNKTyFgef/2309ee1vFUuyNtHBElrkjsuUzL1BY4mcwW3YNIAAI1nFYNIipHm26S.28BYZLZH2dn/";
in
{
    imports = [
	    ../../modules/system
	    ./packages.nix
	    ./hardware-configuration.nix
    ];

    singbox.enable = true;
    amdgpu.enable = true;
    gc.enable = true;
    vm.enable = true;
    yggdrasil.enable = false;
    i2pd.enable = false;
    ssh.enable = true;

    networking.dhcpcd.enable = true;
    zramSwap.enable = true;
    documentation.nixos.enable = false;

    programs.fish.enable = true;
	users = {
		defaultUserShell = pkgs.fish;
		users."${user}" = {
			isNormalUser = true;
			extraGroups = ["wheel"];
            hashedPassword = passHash;
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
    };

    time.timeZone = "Europe/Moscow";
    networking.hostName = "nixos";
    i18n.defaultLocale = "en_US.UTF-8";
    
    system.stateVersion = "24.05";
}

