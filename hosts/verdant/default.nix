{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    system = "x86_64-linux";
    modules = [
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.default
        inputs.nixvim.nixosModules.nixvim
        ./hardware.nix
        ../../modules
        ({ config, ... }:

        let
            home = config.users.users.mlwpsh.home;
            sway = {
                mod = config.home-manager.users."mlwpsh".wayland.windowManager.sway.config.modifier;
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
            };
        in {
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
            boot.loader.systemd-boot.enable = true;
            boot.loader.efi.canTouchEfiVariables = true;

            time.timeZone = "America/Los_Angeles";

            services.libinput.enable = true;

            programs.nix-ld.enable = true;

            mallows = {
                networking = {
                    enable = true;
                    hostname = "verdant";
                };

                verdant = {
                    wireguard.enable = true;
                };

                virtualisation = {
                    enable = true;
                    qemu.enable = true;
                };

                sops.enable = true;
                ssh.enable = true;
                python.enable = true;
                lua.enable = true;
                etc.enable = true;
                home = {
                    "1password".enable = true;
                    bash.enable = true;
                    steam.enable = false;
                    git.enable = true;
                    zathura.enable = true;
                    etc.enable = true;
                    sway = {
                        enable = true;
                        startup = [
                            { command = "foot tmux"; }
                            { command = "librewolf"; }
                        ];
                        assigns = {
                            "${sway.ws1}" = [
                                { app_id = "mpv"; }
                            ];
                            "${sway.ws2}" = [
                                { app_id = "librewolf"; }
                            ];
                            "${sway.ws3}" = [
                                { class = "vesktop"; }
                            ];
                        };
                        extraKeybindings = {
                            "${sway.mod}+n" = "exec brightnessctl s 10%-";
                            "${sway.mod}+m" = "exec brightnessctl s +10%";
                        };
                        input = {
                            "1739:52544:SYNA7DAB:01_06CB:CD40_Touchpad" = {
                                dwt = "enabled";
                                tap = "enabled";
                                middle_emulation = "enabled";
                                natural_scroll = "enabled";
                            };
                        };
                        output = {
                            "*" = {
                                bg = "${home}/media/image/bgr/active.png fill";
                            };
                            "eDP-1" = {
                                mode = "1920x1080@60Hz";
                                pos = "0 0";
                            };
                        };
                        workspaceOutputAssign = [
                            { output = "eDP-1"; workspace = "${sway.ws1}"; }
                            { output = "eDP-1"; workspace = "${sway.ws2}"; }
                            { output = "eDP-1"; workspace = "${sway.ws3}"; }
                            { output = "eDP-1"; workspace = "${sway.ws4}"; }
                            { output = "eDP-1"; workspace = "${sway.ws5}"; }
                            { output = "eDP-1"; workspace = "${sway.ws6}"; }
                            { output = "eDP-1"; workspace = "${sway.ws7}"; }
                            { output = "eDP-1"; workspace = "${sway.ws8}"; }
                            { output = "eDP-1"; workspace = "${sway.ws9}"; }
                            { output = "eDP-1"; workspace = "${sway.ws10}"; }
                        ];
                    };
                };
            };

            # :<
            system.stateVersion = "25.11";
        })
    ];
}
