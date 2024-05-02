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