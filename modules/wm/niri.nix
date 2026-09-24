{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.wm.niri.enable = lib.mkEnableOption "enable the niri Wayland compositor";

  config = lib.mkIf config.wm.niri.enable {
    programs.niri = {
      enable = true;
      # Override the broken package directly in module
      package = pkgs.niri-unstable;
    };
  };
}
