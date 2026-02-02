{ config, pkgs, lib, ... }:

{
    options.verdant.wireguard.enable = lib.mkEnableOption "wireguarddddd";
    config = lib.mkIf config.verdant.wireguard.enable {
        sops.secrets."wireguard/preshared/verdant" = { };
        sops.secrets."wireguard/private/verdant" = { };
        sops.secrets."wireguard/public/verdant" = { };
        sops.secrets."wireguard/endpoint" = { };
        sops.templates."wg0.conf" = {
            path = "/etc/wireguard/wg0.conf";
            content = ''
                [Interface]
                Address = 10.7.0.5/24, fddd:2c4:2c4:2c4::5/64
                DNS = 192.168.1.1
                PrivateKey = ${config.sops.placeholder."wireguard/private/verdant"}

                [Peer]
                PublicKey = ${config.sops.placeholder."wireguard/public/verdant"}
                PresharedKey = ${config.sops.placeholder."wireguard/preshared/verdant"}
                AllowedIPs = 0.0.0.0/0, ::/0
                Endpoint = ${config.sops.placeholder."wireguard/endpoint"}
                PersistentKeepalive = 25
            '';
        };

        environment.systemPackages = with pkgs; [ wireguard-tools ];
        networking.firewall.allowedUDPPorts = [ 46752 ];
        networking.wg-quick.interfaces.wg0 = {
            configFile = "/etc/wireguard/wg0.conf";
            autostart = true;
        };
    };
}
