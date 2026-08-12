{ lib, config, ... }:

{
  options.common-settings = {
    enable = lib.mkEnableOption "common settings that can be utilized for multiple hosts";

    gc.options = lib.mkOption {
      type = lib.types.str;
      description = "additional CLI options passed to `nh clean`, e.g. \"--delete-older-than 7d\"";
    };

    flake = lib.mkOption {
      type = lib.types.str;
      description = "path to the flake to use for `nh`, e.g. \"/home/atomic-shadow/.dotfiles\"";
    };
  };

  config = lib.mkIf config.common-settings.enable {
    services.printing.enable = true;

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      auto-optimise-store = true;
    };

    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = config.common-settings.gc.options;
      flake = config.common-settings.flake;
    };
  };
}
