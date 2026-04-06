{ config, pkgs, lib, ... }:

{
    modules = [
        ./common.nix
    ];
    options.vbox.enable = lib.mkEnableOption "boxboxbox";
    config = lib.mkIf config.vbox.enable {
        # why does this need dnsmasq
        environment.systemPackages = with pkgs; [ dnsmasq ];
        users.groups.vboxusers.members = [ "mlwpsh" ];
    };
}
