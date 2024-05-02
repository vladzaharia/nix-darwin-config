{
  description = "Vlad's Darwin Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }:
    {
      # Build default darwin flake with:
      # $ darwin-rebuild switch --flake .#default
      darwinConfigurations.default = nix-darwin.lib.darwinSystem {
        specialArgs =
          inputs
          // {
            cfg = {
              homebrew = {
                masApps = false;
              };
            };
          };

        modules = [
          ./src/modules/nix-darwin.nix
          ./src/modules/pkgs.nix
        ];
      };

      # Build device-specific flake with:
      # $ darwin-rebuild switch --flake .
      darwinConfigurations."Vlads-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        specialArgs =
          inputs
          // {
            cfg = {
              homebrew = {
                masApps = true;
              };
              user = {
                name = "vlad";
              };
            };
          };

        modules = [
          ./src/modules/nix-darwin.nix
          ./src/modules/aarch64.nix
          ./src/modules/pkgs.nix
          ./src/modules/homebrew.nix
          ./src/modules/user.nix
        ];
      };
      darwinConfigurations."Mac-6LV21Y21X" = import ./src/config/Mac-6LV21Y21X.nix;

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.default.pkgs;
    };
}
