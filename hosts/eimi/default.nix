{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    system = "x86_64-linux";
    modules = [
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
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

            security.polkit.enable = true;

            environment.variables = {
                RUSTICL_ENABLE = "radeonsi";
            };

            time.timeZone = "America/Los_Angeles";

            security.rtkit.enable = true;
            services.pipewire = {
                enable = true;
                alsa.enable = true;
                pulse.enable = true;
            };

            programs.nix-ld.enable = true;
            virtualisation.docker.enable = true;

            mallows = {
                networking = {
                    enable = true;
                    hostname = "eimi";
                };

                services = {
                    proxmox-status.enable = true;
                    mpd.enable = true;
                };

                virtualisation = {
                    enable = true;
                    qemu.enable = true;
                    vbox.enable = true;
                };

                sops.enable = true;
                keyd.enable = true;
                ssh.enable = true;
                python.enable = true;
                lua.enable = true;
                mcsr.enable = true;
                etc.enable = true;
                home = {
                    "1password".enable = true;
                    steam.enable = true;
                    bash.enable = true;
                    git.enable = true;
                    zathura.enable = true;
                    etc.enable = true;
                    sway = {
                        enable = true;
                        startup = [
                            { command = "foot tmux"; }
                            { command = "librewolf"; }
                            { command = "discord"; }
                            { command = "steam"; }
                            { command = "strawberry"; }
                        ];
                        assigns = {
                            "${sway.ws1}" = [
                                { app_id = "mpv"; }
                            ];
                            "${sway.ws2}" = [ ];
                            "${sway.ws3}" = [
                                { app_id = "org.kde.kdenlive"; }
                            ];
                            "${sway.ws4}" = [
                                { class = "steam"; }
                                { app_id = "org.prismlauncher.PrismLauncher"; }
                            ];
                            "${sway.ws5}" = [
                                { class = "tf_linux64"; }
                                { class = "Celeste"; }
                                { class = "factorio"; }
                                { class = "Nomi-CEu — Normal Mode — v1.7.7"; }
                                { app_id = "waywall"; }
                            ];
                            "${sway.ws6}" = [
                                { app_id = "librewolf"; }
                            ];
                            "${sway.ws7}" = [
                                { class = "discord"; }
                                { class = "Mumble"; }
                            ];
                            "${sway.ws8}" = [
                                { app_id = "org.strawberrymusicplayer.strawberry"; }
                            ];
                            "${sway.ws9}" = [ ];
                            "${sway.ws10}" = [ ];
                        };
                        input = {
                            # Pulsar Xlite v2 Mini wired
                            "9639:64123:Compx_Pulsar_Xlite_Wireless" = {
                                accel_profile = "flat";
                                pointer_accel = "0";
                                natural_scroll = "disabled";
                                left_handed = "disabled";
                            };

                            # Pulsar Xlite v2 Mini wired
                            "9639:64124:Compx_Pulsar_Xlite_Wireless" = {
                                accel_profile = "flat";
                                pointer_accel = "0";
                                natural_scroll = "disabled";
                                left_handed = "disabled";
                            };

                            # EGG OP1we 4kv2 wireless
                            "13159:6512:Endgame_Gear_Endgame_Gear_HS_Dongle" = {
                                accel_profile = "flat";
                                pointer_accel = "0";
                                natural_scroll = "disabled";
                                left_handed = "disabled";
                            };

                            # EGG OP1we 4kv2 wired
                            "13159:6532:Endgame_Gear_OP1w_4k_v2_Wireless_Gaming_Mouse" = {
                                accel_profile = "flat";
                                pointer_accel = "0";
                                natural_scroll = "disabled";
                                left_handed = "disabled";
                            };
                        };
                        output = {
                            "*" = {
                                bg = "${home}/storage/media/image/backgrounds/bgr.png fill";
                            };
                            "DP-3" = {
                                mode = "1920x1080@144Hz";
                                pos = "0 0";
                            };
                            "DP-1" = {
                                mode = "1920x1080@144Hz";
                                transform = "90";
                                pos = "1920 0";
                            };
                        };
                        workspaceOutputAssign = [
                            { output = "DP-3"; workspace = "${sway.ws1}"; }
                            { output = "DP-3"; workspace = "${sway.ws2}"; }
                            { output = "DP-3"; workspace = "${sway.ws3}"; }
                            { output = "DP-3"; workspace = "${sway.ws4}"; }
                            { output = "DP-3"; workspace = "${sway.ws5}"; }
                            { output = "DP-1"; workspace = "${sway.ws6}"; }
                            { output = "DP-1"; workspace = "${sway.ws7}"; }
                            { output = "DP-1"; workspace = "${sway.ws8}"; }
                            { output = "DP-1"; workspace = "${sway.ws9}"; }
                            { output = "DP-1"; workspace = "${sway.ws10}"; }
                        ];
                    };
                };
            };

            # <3
            system.stateVersion = "25.11";
        })
    ];
}
