{ pkgs, ... }: {
	programs.fish.enable = true;
	
	users = {
		defaultUserShell = pkgs.fish;
		users.svd = {
			isNormalUser = true;
			extraGroups = ["wheel" "input"];
			packages = with pkgs; [];
		};
	};
}
