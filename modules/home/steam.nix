{ config, lib, pkgs, ... }:

{
    options.mallows.home.steam.enable = lib.mkEnableOption "steam";
    config = lib.mkIf config.mallows.home.steam.enable {
        home-manager.users."mlwpsh".home.packages = with pkgs; [
            steam
        ];
    };
}
