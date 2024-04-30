{ pkgs, self, ... }: {
    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    # Enable x86/64
    nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
    '';

    # Enable Linux building
    nix.linux-builder.enable = true;
}