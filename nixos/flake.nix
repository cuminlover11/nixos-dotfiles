{
  description = "tunix nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    home-manager = {
	url = "github:nix-community/home-manager/release-26.05";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.tunix = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    modules = [
		  ./configuration.nix
      home-manager.nixosModules.default
	    ];
    };
  };
}
