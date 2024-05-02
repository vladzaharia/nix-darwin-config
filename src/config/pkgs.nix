{ pkgs, ... }: {
    # Install system packages
    environment.systemPackages = pkgs.callPackage ../pkgs/system.nix {};

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Intall fonts
    fonts.fontDir.enable = true;
    fonts.fonts = pkgs.callPackage ../pkgs/fonts.nix {};
}