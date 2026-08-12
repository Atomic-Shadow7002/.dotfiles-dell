# Extracted out of wm/niri.nix's package list -- xwayland-satellite runs
# alongside niri to give Xwayland-only apps a compositor to talk to.
{ pkgs, ... }:

{
  home.packages = [ pkgs.xwayland-satellite ];
}
