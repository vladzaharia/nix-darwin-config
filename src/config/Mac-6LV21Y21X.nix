{ inputs, ... }: {
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
        ./src/modules/nix-darwin.nix
        ./src/modules/aarch64.nix
        ./src/modules/pkgs.nix
        ./src/modules/homebrew.nix
        ./src/modules/user.nix
    ];
}