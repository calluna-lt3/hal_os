{ config, pkgs, lib, ... }:

{
    options.mallows.virtualisation.vbox.enable = lib.mkEnableOption "boxboxbox";
    config = lib.mkIf config.mallows.virtualisation.vbox.enable {
        environment.systemPackages = with pkgs; [ dnsmasq ];
        users.groups.vboxusers.members = [ "mlwpsh" ];
    };
}
