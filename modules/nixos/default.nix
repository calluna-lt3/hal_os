{ ... }:

{
    imports = [
        ./services
        ./neovim
        ./mcsr
        ./users.nix
        ./keyd.nix
        ./networking.nix
        ./sops.nix
        ./sway.nix
        ./lua.nix
        ./ssh.nix
        ./python.nix
        ./virtualbox.nix
        ./etc.nix
    ];
}
