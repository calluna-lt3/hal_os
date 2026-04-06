{ config, lib, pkgs, ... }:

{
    options.mallows.networking = {
        enable = lib.mkEnableOption "iwd + dhcpcd stack";
        hostname = lib.mkOption {
            description = "system hostname";
            type = lib.types.uniq lib.types.str;
        };
    };

    config = lib.mkIf config.mallows.networking.enable {
        networking.hostName = config.mallows.networking.hostname;
        networking.dhcpcd.enable = true;
        networking.wireless.iwd = {
            enable = true;
            settings = {
                Settings = {
                    AutoConnect = true;
                };
            };
        };
    };
}
