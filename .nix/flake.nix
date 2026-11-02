{
  description = "Ruslan's NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, helium, zen-browser, ... }: {
    nixosConfigurations.rusmachine = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs.zen = zen-browser;

      modules = [
        ./configuration.nix
        {
          nixpkgs.overlays = [ helium.overlays.default ];
        }
      ];
    };
  };
}
