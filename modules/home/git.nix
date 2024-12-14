{ lib, config, ... }:

with lib;

let
  	cfg = config.git;
in
{
	options.git = {
    	enable = mkEnableOption "Enable git settings";
  	};

  	config = mkIf cfg.enable {
    	programs.git = {
      	enable = true;
      	userName = "SVD";
      	userEmail = "svdforever@tuta.io";
    };
  };
}
