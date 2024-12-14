{config, lib, ...}:
with lib;
let
  cfg = config.fish;
in
{
    options.fish = {
        enable = mkEnableOption "Enable fish shell";
    };

    config = mkIf cfg.enable {
        programs.fish = {
            enable = true;
                interactiveShellInit = ''
                    set fish_greeting # Disable greeting

                    if status is-login
                        if test (tty) = /dev/tty1
                            dbus-run-session Hyprland
                        end
                    end
                '';
        };
    };
}