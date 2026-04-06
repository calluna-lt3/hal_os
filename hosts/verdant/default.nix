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
        ({ config, ... } :{
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

                sops.enable = true;
                ssh.enable = true;
                sway.enable = true;
                python.enable = true;
                lua.enable = true;
                qemu.enable = true;
                etc.enable = true;
                home = {
                    "1password".enable = true;
                    bash.enable = true;
                    steam.enable = false;
                    git.enable = true;
                    zathura.enable = true;
                    etc.enable = true;
                };
            };

            # :<
            system.stateVersion = "25.11";
        })
    ];
}
