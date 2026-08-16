{
  description = "tunix nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    home-manager = {
	url = "github:nix-community/home-manager/release-26.05";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
	url = "github:0xc000022070/zen-browser-flake";
};
    areofyl-fetch.url = "github:areofyl/fetch";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, ... }: {
    nixosConfigurations.tunix = nixpkgs.lib.nixosSystem {
	    system = "x86_64-linux";
	    specialArgs = {inherit zen-browser inputs; };
	    modules = [
		    ./configuration.nix
      	home-manager.nixosModules.default
        {
          home-manager.extraSpecialArgs = {inherit inputs; };
        }
	    ];
    };
  };
}
