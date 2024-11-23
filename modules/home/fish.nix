{
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
}