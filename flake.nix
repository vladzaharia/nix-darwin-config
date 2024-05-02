{
  description = "Vlad's Darwin Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, nixpkgs, ... }:
    {
      # Build default darwin flake with:
      # $ darwin-rebuild switch --flake .#default
      darwinConfigurations.default = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };

        modules = [
          ./src/config/nix-darwin.nix
          ./src/config/pkgs.nix
        ];
      };

      # Build device-specific flake with:
      # $ darwin-rebuild switch --flake .
      darwinConfigurations."Vlads-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        specialArgs =
          inputs
          // {
            username = "vlad";
          };

        modules = [
          ./src/config/nix-darwin.nix
          ./src/config/aarch64.nix
          ./src/config/pkgs.nix
          ./src/config/user.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "vlad";

              # Optional: Declarative tap management
              # taps = {
              #   "homebrew/homebrew-core" = homebrew-core;
              #   "homebrew/homebrew-cask" = homebrew-cask;
              # };

              # Optional: Enable fully-declarative tap management
              #
              # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              mutableTaps = true;
            };
          }
        ];
      };
      darwinConfigurations."Mac-6LV21Y21X" = nix-darwin.lib.darwinSystem {
        specialArgs =
          inputs
          // {
            username = "v.zaharia";
          };

        modules = [
          ./src/config/nix-darwin.nix
          ./src/config/aarch64.nix
          ./src/config/pkgs.nix
          ./src/config/user.nix
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.default.pkgs;
    };
}
