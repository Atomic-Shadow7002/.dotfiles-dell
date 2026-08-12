{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.android.enable = lib.mkEnableOption "enable android module";

  config = lib.mkIf config.android.enable {
    # adb / fastboot are now provided via packages
    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}
