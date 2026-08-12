# Relocated here from niri/matugen/ -- matugen is a theming engine, not a
# niri-specific concern, even though niri's colorscheme is what triggers it.
{ pkgs, ... }:

{
  home.packages = [ pkgs.matugen ];

  xdg.configFile."matugen/config.toml".source = ../niri/matugen/config.toml;
  xdg.configFile."matugen/templates".source = ../niri/matugen/templates;
}
