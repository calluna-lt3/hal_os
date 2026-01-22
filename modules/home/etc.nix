{ config, pkgs, lib, ... }:

{
    options.home.etc.enable = lib.mkEnableOption "etc !! etc !!";
    config = lib.mkIf config.home.etc.enable {
        home-manager.users."mlwpsh" = {
            home.packages = with pkgs; [
                discord
                kdePackages.kdenlive
                librewolf
                neovim
                nicotine-plus
                obs-studio
                ripgrep
                strawberry
                krita
                weechat
                lutris
                rustfmt

                (prismlauncher.override {
                    additionalPrograms = [ libxtst ];
                    jdks = [ temurin-jre-bin ];
                })
            ];
        };
    };
}
