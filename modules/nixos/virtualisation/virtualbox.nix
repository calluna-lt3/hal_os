{ config, pkgs, lib, ... }:

{
    options.virtualisation.vbox.enable = lib.mkEnableOption "boxboxbox";
    config = lib.mkIf config.virtualisation.vbox.enable {
        environment.systemPackages = with pkgs; [ dnsmasq ];
        users.groups.vboxusers.members = [ "mlwpsh" ];
    };
}
