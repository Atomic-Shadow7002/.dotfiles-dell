# Extracted out of wm/niri.nix, where it was previously just a stray package
# in an unrelated home.packages list.
{ pkgs, ... }:

{
  home.packages = [ pkgs.nautilus ];
}
