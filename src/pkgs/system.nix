{ pkgs, ... }:

with pkgs; [
    # Applications
    _1password-gui

    # Text editors
    nano
    vim

    # VS Code
    vscode
    vscode-extensions.eamodio.gitlens
    vscode-extensions.tailscale.vscode-tailscale
    vscode-extensions.coder.coder-remote
    vscode-extensions.ms-vscode-remote.remote-ssh
    vscode-extensions.ms-vscode-remote.remote-containers
    vscode-extensions.github.codespaces
    vscode-extensions.github.vscode-github-actions
    vscode-extensions.github.vscode-pull-request-github
    vscode-extensions.ms-azuretools.vscode-docker
    vscode-extensions.dbaeumer.vscode-eslint
    vscode-extensions.yzhang.markdown-all-in-one
    vscode-extensions.ms-vscode.makefile-tools
    vscode-extensions.bbenoist.nix
    vscode-extensions.esbenp.prettier-vscode
    vscode-extensions.humao.rest-client
    vscode-extensions.redhat.vscode-yaml
    vscode-extensions.golang.go

    # Docker
    colima
    docker
    docker-buildx
    docker-compose
    podman
    podman-tui

    # Utilities
    age
    atuin
    chezmoi
    curl
    direnv
    eza
    git
    gnupg
    htop
    hurl
    jq
    mosh
    starship
    vault-bin

    # Nix tools
    cachix
    devenv 
    nixfmt-classic
]