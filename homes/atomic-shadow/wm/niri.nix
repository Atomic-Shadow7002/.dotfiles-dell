{ pkgs, ... }:

let
  qt6ct = pkgs.qt6Packages.qt6ct.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ../_patches/qt6ct.patch
    ];
  });

  pywal = pkgs.pywal16.overridePythonAttrs (old: {
    makeWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      (pkgs.lib.makeBinPath [ pkgs.imagemagick ])
    ];
  });
in
{
  programs.niri.config = null;

  xdg.configFile."niri/config.kdl".source = ../niri/config.kdl;

  programs.dank-material-shell.enable = true;
  programs.dank-material-shell.niri.includes.enable = false;
  programs.dank-material-shell.enableSystemMonitoring = true;
  programs.dank-material-shell.enableVPN = true;
  programs.dank-material-shell.enableDynamicTheming = true;
  programs.dank-material-shell.enableAudioWavelength = true;
  programs.dank-material-shell.enableCalendarEvents = false;

  home.packages = [
    pkgs.dsearch
    pkgs.nautilus
    pywal
    pkgs.pywalfox-native
    qt6ct
  ];
}
