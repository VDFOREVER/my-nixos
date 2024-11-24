{
    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session"; 
            };

            listener = [
                {
                    timeout = 400;
                    on-timeout = "hyprlock";
                }
            ];
        };
    };
}