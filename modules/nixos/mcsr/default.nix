{ config, pkgs, lib, inputs, ... }:
let
    mcsrPkgs = inputs.mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};
in {
    imports = [ inputs.mcsr-nixos.nixosModules.waywall ];
    options.mallows.mcsr.enable = lib.mkEnableOption "mcsr";
    config = lib.mkIf config.mallows.mcsr.enable {
        environment.systemPackages = with pkgs; [
            mcsrPkgs.ninjabrain-bot
            (prismlauncher.override {
                jdks = [
                    mcsrPkgs.graalvm-21
                    pkgs.jre8
                ];
            })
        ];

        # https://its-saanvi.github.io/linux-mcsr/drag-clicking.html
        environment.etc."libinput/local-overrides.quirks".text = ''
            [Never Debounce]
            MatchUdevType=mouse
            ModelBouncingKeys=1
            '';

        programs.waywall = {
            enable = true;
            config = {
                enableWaywork = true;
                programs = [ mcsrPkgs.ninjabrain-bot ];
                files = {
                    eye_overlay = ./eye-overlay.png;
                    thin = ./thin.png;
                    tall = ./tall.png;
                    wide = ./wide.png;
                };

                source = ./init.lua;
            };
        };
    };
}
