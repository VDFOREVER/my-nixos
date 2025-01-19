{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.ssh;
in
{
	options.ssh = {
    	enable = mkEnableOption "Enable ssh";
  	};

	config = mkIf cfg.enable {
        services.openssh = {
            enable = true;
            ports = [ 22 ];
        };
	};
}
