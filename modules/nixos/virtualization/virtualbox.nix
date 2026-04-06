{ config, pkgs, lib, ... }:

{
    imports = [
        ./common.nix
    ];
    options.vbox.enable = lib.mkEnableOption "boxboxbox";
    config = lib.mkIf config.vbox.enable {
        environment.systemPackages = with pkgs; [ dnsmasq ];
        users.groups.vboxusers.members = [ "mlwpsh" ];
    };
}
