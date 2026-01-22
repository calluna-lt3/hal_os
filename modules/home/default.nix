{ ... }:

{
    imports = [
        ./1password.nix
        ./bash.nix
        ./zathura.nix
        ./git.nix
        ./steam.nix
        ./etc.nix
    ];

    # <3
    home-manager.users."mlwpsh".home.stateVersion = "25.11";
}
