{ config, lib, pkgs, ...}:

{
    options.home.zathura.enable = lib.mkEnableOption "wp";
    config = lib.mkIf config.home.zathura.enable {
        home-manager.users."mlwpsh".programs.zathura = {
            enable = true;
            options = {
                recolor             = true;
                recolor-darkcolor   = "#bbbbbb";
                recolor-lightcolor  = "#191919";
                default-bg          = "#3d3839";
                inputbar-bg         = "#191919";
                statusbar-bg        = "#3d3839";
            };
        };
    };
}
