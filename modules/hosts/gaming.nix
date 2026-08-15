{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.gaming.enable = lib.mkEnableOption "enable gaming module (Steam, GameMode, MangoHud, Gamescope)";

  config = lib.mkIf config.gaming.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = [
      pkgs.mangohud
      pkgs.gamescope
    ];
  };
}
