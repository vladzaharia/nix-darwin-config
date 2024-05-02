 {cfg, lib, ...}: {
    homebrew = {
        enable = true;

        brews = [
            "coder/coder/coder"
            "tidbyt/tidbyt/pixlet"
        ];

        casks = [];

        taps = [
            "buildpacks/tap"
            "coder/coder"
            "hashicorp/tap"
            # "homebrew/cask"
            # "homebrew/core"
            "tidbyt/tidbyt"
        ];

        masApps = lib.mkIf (cfg.homebrew.masApps) { 
            "1Password for Safari" = 1569813296;
            "Adguard for Safari" = 1440147259;
            Flightly = 1358823008;
            Infuse = 1136220934;
            Meshtastic = 1586432531;
            "Prompt 3" = 1594420480;
            Tailscale = 1475387142;
        };
    };
}