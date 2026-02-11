{ config, pkgs, lib, inputs, ... }:
let
    mcsrPkgs = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in {
    imports = [ inputs.mcsr-nixos.nixosModules.waywall ];
    options.mcsr.enable = lib.mkEnableOption "mcsr";
    config = lib.mkIf config.mcsr.enable {
        environment.systemPackages = with pkgs; [
            mcsrPkgs.ninjabrain-bot
            (prismlauncher.override {
                jdks = [ mcsrPkgs.graalvm-21 ];
            })
        ];

        programs.waywall = {
            enable = true;
            config = {
                enableWaywork = true;
                programs = [ mcsrPkgs.ninjabrain-bot ];
                files = {
                    eye_overlay = ./eye-overlay.png;
                };

                source = ./init.lua;
            };
        };
    };
}
