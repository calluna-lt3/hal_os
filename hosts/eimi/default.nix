{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    system = "x86_64-linux";
    modules = [
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        ./hardware.nix
        ../../modules/nixos
        ../../modules/home
        {
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

            # programs.nix-ld.enable = true; # ?

            networking = {
                enable = true;
                hostname = "eimi";
            };

            sops.enable = true;
            sway.enable = true;
            keyd.enable = true;
            etc.enable = true;
            home = {
                "1password".enable = true;
                bash.enable = true;
                git.enable = true;
                zathura.enable = true;
                etc.enable = true;
            };

            # <3
            system.stateVersion = "25.11";
        }
    ];
}
