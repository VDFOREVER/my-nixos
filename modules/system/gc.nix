{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.gc;
in
{
	options.gc = {
    	enable = mkEnableOption "Enable autoclear";
  	};

	config = mkIf cfg.enable {
		nix.gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 30d";
		};
	};
}
