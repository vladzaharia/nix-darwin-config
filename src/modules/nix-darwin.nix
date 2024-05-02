{ pkgs, self, ... }: {
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    nix = {
        package = pkgs.nix;
        settings = {
            substituters = [
                "https://nix.polaris.rest/vlad"
                "https://nix-community.cachix.org"
                "https://cache.nixos.org/"
            ];
            trusted-public-keys = [
                "vlad:DGGKUwr8GzzEwh9WTubKB898f4aZkjcWyvxPbZhScV4="
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];

            "extra-experimental-features" = [ "nix-command" "flakes" ];
        };
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs = {
        gnupg.agent.enable = true;
        zsh.enable = true;  # default shell on catalina
    };
    
    # Enable Touch ID on sudo
    security.pam.enableSudoTouchIdAuth = true;
}