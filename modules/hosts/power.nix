# Laptop power management. Didn't exist before -- the previous host never
# needed it. `power-profiles-daemon` is the modern, DE-integrated way to
# switch power/performance profiles (don't run it alongside TLP, they fight
# over the same knobs). `thermald` is Intel-specific thermal throttling
# management, relevant here since the G15's CPU is Intel.
#
# NOTE: Dell doesn't expose a reliable, model-agnostic Linux interface for
# fan curves or battery charge thresholds on the G15 line (unlike e.g.
# ThinkPads). This module intentionally does not attempt fan control --
# day-to-day thermal behaviour is whatever the BIOS's G-key performance mode
# gives you.
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
