{ config, lib, pkgs, ...}:
with lib;
let
  cfg = config.singbox;
in
{
  options.singbox = {
    enable = mkEnableOption "Enable singbox proxy to my XRay vpn";
  };

  config = mkIf cfg.enable {
    systemd.services.singbox = {
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.sing-box}/bin/sing-box -c /home/svd/nix/other/singbox/config run";
      };
    };
    systemd.services.singbox-tun = {
      wantedBy = [ "singbox.service" ];
      partOf = [ "singbox.service" ];
      path = with pkgs; [
        iptables
        iproute2
        procps
        sing-box
      ];
      serviceConfig = {
        ExecStart = "${pkgs.bash}/bin/bash /home/svd/nix/other/singbox/vpn-run-root.sh start /home/svd/nix/other/singbox/sing-box-vpn.json";
        ExecStop = "${pkgs.bash}/bin/bash /home/svd/nix/other/singbox/vpn-run-root.sh stop /home/svd/nix/other/singbox/sing-box-vpn.json";
      };
    };
    services = {
      resolved.enable = true;
      dnscrypt-proxy2 = {
        enable = true;
        settings = {
          server_names = [
            "cloudflare"
            "scaleway-fr"
            "google"
            "yandex"
          ];
          listen_addresses = [
            "127.0.0.1:53"
            "[::1]:53"
          ];
        };
      };
    };
    networking = {
      nameservers = [
        "::1"
        "127.0.0.1"
      ];
      resolvconf.dnsSingleRequest = true;
    };
  };
}