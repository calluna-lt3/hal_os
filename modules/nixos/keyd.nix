{ config, lib, pkgs, ... }:

{
    options.mallows.keyd.enable = lib.mkEnableOption "f3f3f3f3f3";
    config = lib.mkIf config.mallows.keyd.enable {
        users.users."mlwpsh".extraGroups = [ "keyd" ];
        systemd.services.keyd.wantedBy = lib.mkForce [ ];
        services.keyd = {
            enable = true;
            keyboards.default = {
                ids = [ "*" ]; # TODO
                settings = {
                    main = {
                        alt = "f";
                        f = "y";
                    };
                };
            };
        };
    };
}
