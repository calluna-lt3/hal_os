{ config, pkgs, lib, ... }:

{
    options.home.etc.enable = lib.mkEnableOption "etc !! etc !!";
    config = lib.mkIf config.home.etc.enable {
        home-manager.users."mlwpsh" = {
            home.packages = with pkgs; [
                discord
                kdePackages.kdenlive
                librewolf
                nicotine-plus
                obs-studio
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
