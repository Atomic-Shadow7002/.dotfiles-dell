{ pkgs, ... }:

{
  home.username = "atomic-shadow";
  home.homeDirectory = "/home/atomic-shadow";
  home.stateVersion = "25.05"; # DO NOT CHANGE!

  # Fontconfig stuff.
  fonts.fontconfig.enable = true;

  # Let home-manager update itself.
  programs.home-manager.enable = true;

  # Allow unfree.
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  imports = [
    ./browser/firefox.nix
    ./packages.nix
    ./shell/bat.nix
    ./shell/direnv.nix
    ./shell/eza.nix
    ./shell/fish.nix
    ./shell/fzf.nix
    ./shell/starship.nix
    ./shell/zoxide.nix
    ./terminal/ghostty.nix
    ./editor/helix.nix
    ./vcs/git.nix
    ./vcs/jujutsu.nix
    ./multiplexer/zellij.nix
    ./filemanager/nautilus.nix
    ./filemanager/yazi.nix
    ./wm/niri.nix
    ./wm/xwayland-satellite.nix
    ./theming/matugen.nix
    ./security/gpg.nix
    ./connectivity/kdeconnect.nix
    ./recording/obs-studio.nix
    ./package/flatpak.nix
  ];
}
