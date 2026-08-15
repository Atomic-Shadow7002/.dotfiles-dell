{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.graphics = {
    enable = lib.mkEnableOption "enable graphics module";

    enable32Bit = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "also install 32-bit graphics libraries (needed by Steam/Proton and OBS's vkcapture)";
    };

    intel.enable = lib.mkEnableOption "enable Intel iGPU support (VAAPI hardware video decode)";

    nvidia = {
      enable = lib.mkEnableOption "enable nvidia dGPU support";

      prime = {
        enable = lib.mkEnableOption "enable nvidia PRIME hybrid-graphics support";

        mode = lib.mkOption {
          type = lib.types.enum [
            "offload"
            "sync"
            "none"
          ];
          default = "offload";
          description = ''
            PRIME mode:
              - "offload": the iGPU drives the display at all times; the dGPU
                stays powered down until you launch something with
                `nvidia-offload <command>`. Best battery life.
              - "sync": the dGPU always drives the display. Best performance
                and effortless external-monitor support; costs battery even
                at idle.
              - "none": no PRIME wiring (only meaningful if prime.enable is
                false too -- kept as an explicit, self-documenting option
                rather than silently doing nothing).
          '';
        };

        intelBusId = lib.mkOption {
          type = lib.types.str;
          description = ''the Intel iGPU's PCI bus id, formatted like "PCI:0@0:2:0" (see the NixOS wiki's Nvidia page for how to derive it from `lspci`)'';
        };

        nvidiaBusId = lib.mkOption {
          type = lib.types.str;
          description = ''the nvidia dGPU's PCI bus id, formatted like "PCI:1@0:0:0"'';
        };
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.graphics.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = config.graphics.enable32Bit;
      };
    })

    (lib.mkIf (config.graphics.enable && config.graphics.intel.enable) {
      hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];
      environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
    })

    (lib.mkIf (config.graphics.enable && config.graphics.nvidia.enable) {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      hardware.nvidia-container-toolkit.enable = true;
    })

    (lib.mkIf
      (config.graphics.enable && config.graphics.nvidia.enable && config.graphics.nvidia.prime.enable)
      {
        hardware.nvidia.prime = lib.mkMerge [
          {
            intelBusId = config.graphics.nvidia.prime.intelBusId;
            nvidiaBusId = config.graphics.nvidia.prime.nvidiaBusId;
          }
          (lib.mkIf (config.graphics.nvidia.prime.mode == "offload") {
            offload.enable = true;
            offload.enableOffloadCmd = true;
          })
          (lib.mkIf (config.graphics.nvidia.prime.mode == "sync") {
            sync.enable = true;
          })
        ];
      }
    )
  ];
}
