{ pkgs, ... }:

with pkgs; [
    # Built in fonts
    font-awesome_5
    jetbrains-mono
    monaspace

    # Custom fonts
    (callPackage ../../lib/font-monolisa { })
    (callPackage ../../lib/font-outfit { })
    (callPackage ../../lib/font-nerdfonts { })
]