{ lib, config, pkgs, ... }:

{
  options.wm.plasma.enable = lib.mkEnableOption "enable the Plasma 6 desktop session";

  config = lib.mkIf config.wm.plasma.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = [
      pkgs.kdePackages.kate
      pkgs.kdePackages.elisa
      pkgs.kdePackages.khelpcenter
    ];
  };
}
