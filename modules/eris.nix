{ config, lib, pkgs, ... }:
{
  sops.secrets.cache-priv-key-pem = {};
  systemd.services.eris-git.serviceConfig = {
    BindReadOnlyPaths = lib.mkForce [
      "/etc/eris"
      "/etc/nixos/secrets"
    ];
    User = "eris";
    ExecStartPre = "+${pkgs.coreutils}/bin/install -o eris -m400 ${config.sops.secrets.cache-priv-key-pem.path} /run/cache-priv-key.pem";
  };
  services.eris-git.enable = true;
  services.eris-git.configFile = toString (pkgs.writeText "eris.conf" ''
    {
      signing => {
        host    => 'doctor-who-cache.thalheim.io',
        private => '/run/cache-priv-key.pem',
      },
      listen => [
        'http://[::]:5001',
      ],
    }
  '');
  networking.firewall.allowedTCPPorts = [ 5001 ];
}
