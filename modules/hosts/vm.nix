{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.vm = {
    enable = lib.mkEnableOption "enable vm module";
    kvm.enable = lib.mkEnableOption "enable kvm";
    waydroid.enable = lib.mkEnableOption "enable waydroid";
  };

  config = lib.mkMerge [

    (lib.mkIf config.vm.enable {
      virtualisation.libvirtd = {
        enable = true;

        qemu = {
          swtpm.enable = true;
        };

        # Intentionally empty: VMs are NAT-only, not bridged onto the real
        # network. Add interface names here if you actually want bridging.
        allowedBridges = [ ];
      };
      environment.systemPackages = with pkgs; [
        virt-manager
      ];
    })

    (lib.mkIf (config.vm.enable && config.vm.kvm.enable) {
      virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;
    })

    (lib.mkIf (config.vm.enable && config.vm.waydroid.enable) {
      virtualisation.waydroid.enable = true;
    })
  ];
}
