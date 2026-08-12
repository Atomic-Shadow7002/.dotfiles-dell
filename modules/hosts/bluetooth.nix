{ lib, config, ... }:

{
  options.bluetooth.enable = lib.mkEnableOption "enable bluetooth module";

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          # Needed for extended features on some peripherals (e.g. battery-
          # level reporting on headsets/controllers) that aren't in the
          # stable BlueZ D-Bus API yet.
          Experimental = true;
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
