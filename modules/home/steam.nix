{ config, lib, pkgs, ... }:

{
    options.home.steam.enable = lib.mkEnableOption "steam";
    config = lib.mkIf config.home.steam.enable {
        home-manager.users."mlwpsh".home.packages = with pkgs; [
            steam
        ];
    };
}
