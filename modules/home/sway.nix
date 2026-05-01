{ config, pkgs, lib, ... }:

let
    left = "h";
    down = "j";
    up = "k";
    right = "l";

    mod = "mod4";
    term = "foot";
    menu = "bemenu-run -i --binding vim";

    # can we do this programatically please so we dont define it 10 times
    ws1 = config.mallows.home.sway.workspaces.ws1;
    ws2 = config.mallows.home.sway.workspaces.ws2;
    ws3 = config.mallows.home.sway.workspaces.ws3;
    ws4 = config.mallows.home.sway.workspaces.ws4;
    ws5 = config.mallows.home.sway.workspaces.ws5;
    ws6 = config.mallows.home.sway.workspaces.ws6;
    ws7 = config.mallows.home.sway.workspaces.ws7;
    ws8 = config.mallows.home.sway.workspaces.ws8;
    ws9 = config.mallows.home.sway.workspaces.ws9;
    ws10 = config.mallows.home.sway.workspaces.ws10;
in {
    options.mallows.home.sway = {
        enable = lib.mkEnableOption "saww youuu";
        extraKeybindings = lib.mkOption {
            description = "extra sway keybinds or keybind overrides";
            type = lib.types.attrs;
            default = { };
        };
        input = lib.mkOption {
            description = "sway inputs here!!";
            type = lib.types.attrs;
            default = { };
        };
        output = lib.mkOption {
            description = "sway outputs here!!";
            type = lib.types.attrs;
            default = { };
        };
        startup = lib.mkOption {
            description = "sway startup commands !!";
            type = lib.types.listOf lib.types.attrs;
            default = [ ];
        };
        # assigned this here because we dont have a good way of referencing
        # ws1 .. ws10 in our host configuration
        workspaces = lib.mkOption {
            description = "which monitor workspaces get assigned to !!";
            type = lib.types.attrs;
            default = {
                ws1 = "1:૮";
                ws2 = "2:˃";
                ws3 = "3:ﻌ";
                ws4 = "4:˂";
                ws5 = "5:ა";
                ws6 = "6:‾";
                ws7 = "7:⁺";
                ws8 = "8:+";
                ws9 = "9:₊";
                ws10 = "10:_";
            };
        };
        workspaceOutputAssign = lib.mkOption {
            description = "names of workspaces";
            type = lib.types.listOf lib.types.attrs;
            default = [ ];
        };
        assigns = lib.mkOption {
            description = "assign programs -> workspaces";
            type = lib.types.attrs;
            default = { };
        };
    };
    config = lib.mkIf config.mallows.home.sway.enable {
        environment.systemPackages = with pkgs; [
            foot
            bemenu
            grim
            slurp
            wl-clipboard
            wl-mirror
            brightnessctl
        ];

        home-manager.users."mlwpsh".wayland.windowManager.sway = {
            enable = true;
            wrapperFeatures.gtk = true;
            checkConfig = false;
            config = {
                input = config.mallows.home.sway.input;
                output = config.mallows.home.sway.output;
                startup = config.mallows.home.sway.startup;
                workspaceOutputAssign = config.mallows.home.sway.workspaceOutputAssign;
                assigns  = config.mallows.home.sway.assigns;
                left = "${left}";
                down = "${down}";
                up = "${up}";
                right = "${right}";
                modifier = "${mod}";
                menu = "${menu}";
                terminal = "${term}";

                keybindings = {
                    "${mod}+${left}" = "focus left";
                    "${mod}+${down}" = "focus down";
                    "${mod}+${up}" = "focus up";
                    "${mod}+${right}" = "focus right";

                    "${mod}+shift+${left}" = "move left";
                    "${mod}+shift+${down}" = "move down";
                    "${mod}+shift+${up}" = "move up";
                    "${mod}+shift+${right}" = "move right";

                    "${mod}+return" = "exec ${term}";
                    "${mod}+d" = "exec ${menu}";
                    "${mod}+shift+x" = "kill";
                    "${mod}+f" = "fullscreen";

                    # FIX SCRIPT PATHS
                    # tbh should make derivations for them.
                    "${mod}+shift+g" = ''exec grim -g "$(slurp)"''; # better output path
                    "${mod}+g" = "exec ${config.users.users.mlwpsh.home}/.scripts/ssc";
                    "${mod}+b" = "exec ${config.users.users.mlwpsh.home}/.scripts/swaybordertoggle";
                    "${mod}+shift+c" = "reload";
                    "${mod}+shift+v" = ''exec swaynag -t warning -m "You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session." -B "Yes, exit sway" "swaymsg exit"'';

                    "${mod}+1" = "workspace ${ws1}";
                    "${mod}+2" = "workspace ${ws2}";
                    "${mod}+3" = "workspace ${ws3}";
                    "${mod}+4" = "workspace ${ws4}";
                    "${mod}+5" = "workspace ${ws5}";
                    "${mod}+q" = "workspace ${ws6}";
                    "${mod}+w" = "workspace ${ws7}";
                    "${mod}+e" = "workspace ${ws8}";
                    "${mod}+r" = "workspace ${ws9}";
                    "${mod}+t" = "workspace ${ws10}";

                    "${mod}+shift+1" = "move container to workspace ${ws1}";
                    "${mod}+shift+2" = "move container to workspace ${ws2}";
                    "${mod}+shift+3" = "move container to workspace ${ws3}";
                    "${mod}+shift+4" = "move container to workspace ${ws4}";
                    "${mod}+shift+5" = "move container to workspace ${ws5}";
                    "${mod}+shift+q" = "move container to workspace ${ws6}";
                    "${mod}+shift+w" = "move container to workspace ${ws7}";
                    "${mod}+shift+e" = "move container to workspace ${ws8}";
                    "${mod}+shift+r" = "move container to workspace ${ws9}";
                    "${mod}+shift+t" = "move container to workspace ${ws10}";

                    "${mod}+shift+space" = "floating toggle";
                    "${mod}+space" = "focus mode_toggle";
                    "${mod}+z" = "mode resize";
                } // config.mallows.home.sway.extraKeybindings;

                modes = {
                    resize = {
                        "${left}" = "resize shrink width 30px";
                        "${down}" = "resize grow height 30px";
                        "${up}" = "resize shrink height 30px";
                        "${right}" = "resize grow width 30px";
                        "escape" = "mode default";
                    };
                };

                window = {
                    titlebar = false;
                    hideEdgeBorders = "smart";
                    border = 1;
                };

                floating = {
                    modifier = "${mod}";
                    titlebar = false;
                    border = 1;
                };

                gaps.smartBorders = "no_gaps";

                colors = {
                    focused = {
                        border = "#ffffffff";
                        background = "#ffffffff";
                        text = "#ffffffff";
                        indicator = "#00000000";
                        childBorder = "#ffffffff";
                    };
                };

                bars = [{
                    position = "top";
                    trayOutput = null;
                    workspaceNumbers = false;
                    statusCommand = "while ${config.users.users.mlwpsh.home}/.scripts/sway-bar/bar.sh; do sleep 1; done";
                    fonts = {
                        names = [ "IBM Plex Mono" ];
                        size = 10.;
                    };
                    colors = {
                        statusline = "#e1dcdc";
                        background  = "#201f1e";
                        inactiveWorkspace = {
                            border = "#201f1e";
                            background = "#201f1e";
                            text = "#e1dcdc";
                        };
                        focusedWorkspace = {
                            border = "#e1dcdc";
                            background = "#e1dcdc";
                            text = "#201f1e";
                        };
                        urgentWorkspace = {
                            border = "#e14b4b";
                            background = "#e14b4b";
                            text = "#e1dcdc";
                        };
                    };
                }];
            };
        };
    };
}
