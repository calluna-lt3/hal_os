{
    description = "mlwpsh";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url                    = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        sops-nix = {
            url                    = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... } @ inputs:
    let

    in {
        nixosConfigurations = {
            eimi    = import ./hosts/eimi    { inherit inputs; };
            verdant = import ./hosts/verdant { inherit inputs; };
        };
    };
}
