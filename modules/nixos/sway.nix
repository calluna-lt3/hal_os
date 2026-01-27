{ config, lib, pkgs, ... }:

{
    # TODO: home manage this
    options.sway.enable = lib.mkEnableOption "swayyy >->";
    config = lib.mkIf config.sway.enable {
        environment.systemPackages = with pkgs; [
            bemenu # TODO: module
            grim
            slurp
            wl-clipboard
        ];

        programs.sway = {
            enable = true;
            wrapperFeatures.gtk = true;
        };

        # TODO: do we need this?
        services.gnome.gnome-keyring.enable = true;
    };
}
