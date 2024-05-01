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
            config = {
              masApps = true;
            };
          };

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
          ./src/config/nix-darwin.nix
          ./src/config/aarch64.nix
          ./src/config/pkgs.nix
          ./src/config/homebrew.nix
          ./src/config/user.nix
        ];
      };
      darwinConfigurations."Mac-6LV21Y21X" = nix-darwin.lib.darwinSystem {
        specialArgs =
          inputs
          // {
            cfg = {
              homebrew = {
                masApps = false;
              };
              user = {
                name = "v.zaharia";
              };
            };
          };

        modules = [
          ./src/config/nix-darwin.nix
          ./src/config/aarch64.nix
          ./src/config/pkgs.nix
          ./src/config/homebrew.nix
          ./src/config/user.nix
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations.default.pkgs;
    };
}
