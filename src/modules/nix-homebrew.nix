{cfg, lib, nix-homebrew, ...}: nix-homebrew.darwinModules.nix-homebrew {
  inherit lib;
    nix-homebrew = {
        # Install Homebrew under the default prefix
        enable = true;

        # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
        enableRosetta = true;

        # User owning the Homebrew prefix
        user = cfg.user.name;

        # Enable nix-darwin tap management
        mutableTaps = true;
    };
}