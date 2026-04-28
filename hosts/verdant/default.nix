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
                        extraKeybindings = {
                            "${sway.mod}+n" = "exec brightnessctl s 10%-";
                            "${sway.mod}+m" = "exec brightnessctl s +10%";
                        };
                        startup = [
                            { command = "exec foot tmux"; }
                            { command = "exec librewolf"; }
                        ];
                    };
                };
            };

            # :<
            system.stateVersion = "25.11";
        })
    ];
}
