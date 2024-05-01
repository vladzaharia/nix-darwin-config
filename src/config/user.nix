{ cfg, ... }:

{
  users.users."${cfg.user.name}"= {
    home = "/Users/${cfg.user.name}";
    description = cfg.user.name;
  };

  nix.settings.trusted-users = [ cfg.user.name ];
}