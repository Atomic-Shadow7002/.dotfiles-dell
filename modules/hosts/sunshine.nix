{ lib, config, ... }:

{
  options.sunshine.enable = lib.mkEnableOption "enable sunshine module";

  # NOTE: if you're streaming out via Moonlight while gaming, make sure
  # graphics.nvidia.prime.mode is "sync" (or you're launching the game with
  # `nvidia-offload`) -- otherwise Sunshine may end up capturing iGPU-rendered
  # frames instead of the dGPU's output.
  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
