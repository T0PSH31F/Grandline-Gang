{
  description = "A new NixOS configuration for luffy";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    clan-core = {
      url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    omarchy-nix = {
      url = "github:henrysipp/omarchy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, flake-parts, clan-core, nixpkgs, omarchy-nix, home-manager, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        clan-core.flakeModules.default
      ];

      clan = {
        meta.name = "Grandline-Gang";
        meta.tld = "internal";

        machines = {
          "luffy" = {
            imports = [
              ./machines/luffy
              omarchy-nix.nixosModules.default
              home-manager.nixosModules.home-manager
            ];
            nixpkgs.hostPlatform = "x86_64-linux";
            time.timeZone = "America/Los_Angeles";
            i18n.defaultLocale = "en_US.UTF-8";
            home-manager.users.t0psh31f = {
              imports = [ 
                ./users/t0psh31f
                omarchy-nix.homeManagerModules.default
              ];
            };
          };
        };
      };
    };
}
