{ config, pkgs, lib, ... }:

{
    options.mallows.home.etc.enable = lib.mkEnableOption "etc !! etc !!";
    config = lib.mkIf config.mallows.home.etc.enable {
        home-manager.users."mlwpsh" = {
            home.packages = with pkgs; [
                discord
                kdePackages.kdenlive
                librewolf
                nicotine-plus
                obs-studio
                xdg-desktop-portal
                xdg-desktop-portal-wlr

                ripgrep
                strawberry
                krita
                weechat
                lutris
                rustfmt
                thunar
            ];
        };
    };
}
