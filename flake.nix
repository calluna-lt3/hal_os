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
        mcsr-nixos = {
            url                    = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim";
            # see docs as to why we don't do the following
            # inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, mcsr-nixos, ... } @ inputs:
    {
        nixosConfigurations = {
            eimi    = import ./hosts/eimi    { inherit inputs; };
            verdant = import ./hosts/verdant { inherit inputs; };
        };
    };
}
