{ lib, config, ... }:

{
  options.power = {
    enable = lib.mkEnableOption "enable power management module";

    thermald.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable thermald (Intel-specific thermal daemon)";
    };
  };

  config = lib.mkIf config.power.enable {
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = config.power.thermald.enable;
  };
}
