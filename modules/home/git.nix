{ config, pkgs, lib, ... }:

{
    options.home.git.enable = lib.mkEnableOption "gitgitgit";
    config = lib.mkIf config.home.git.enable {
        home-manager.users."mlwpsh".programs.git = {
            enable = true;
            settings = {
                user = {
                    name = "calluna-lt3";
                    email = "106458302+calluna-lt3@users.noreply.github.com";
                };
            };
        };
    };
}
