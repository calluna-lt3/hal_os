{ ... }:

{
    imports = [
        ./mcsr
        ./users.nix
        ./keyd.nix
        ./networking.nix
        ./sops.nix
        ./sway.nix
        ./lua.nix
        ./ssh.nix
        ./python.nix
        ./etc.nix
    ];
}
