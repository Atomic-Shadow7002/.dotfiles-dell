{ lib, config, ... }:

{
  options.netmod = {
    enable = lib.mkEnableOption "enable networking module";

    name = lib.mkOption {
      type = lib.types.str;
      description = "the networking hostName";
    };
  };

  config = lib.mkIf config.netmod.enable {
    networking = {
      hostName = config.netmod.name;

      networkmanager.enable = true;

      firewall = rec {
        # KDE Connect
        allowedTCPPortRanges = [
          {
            from = 1714;
            to = 1764;
          }
        ];

        allowedUDPPortRanges = allowedTCPPortRanges;
      };
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

