# Deliberately minimal: this is the system-level Steam *runtime* only.
# GPU overclocking, Lutris/Heroic launcher configs, and emulator setups are
# per-user preference, not system infrastructure -- those belong in
# home-manager (homes/atomic-shadow/), not here.
{ lib, config, pkgs, ... }:

{
  options.gaming.enable = lib.mkEnableOption "enable gaming module (Steam, GameMode, MangoHud, Gamescope)";

  config = lib.mkIf config.gaming.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      # Lets Big Picture be launched straight from the display manager,
      # nested inside gamescope, without going through a full desktop session.
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = [
      pkgs.mangohud
      pkgs.gamescope
    ];
  };
}
