# Full-disk encryption. This module is deliberately host-agnostic: any future
# machine that wants LUKS just imports this and sets `luks.device`.
#
# NOTE: this only wires up the *unlock* side declaratively. Enrolling the TPM
# with a key slot is a one-time, imperative step you run yourself after the
# first successful boot with a passphrase:
#
#   sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+7 /dev/disk/by-uuid/<uuid>
#
# See PARTITIONING.md for the full sequence.
{ lib, config, ... }:

{
  options.luks = {
    enable = lib.mkEnableOption "enable LUKS full-disk encryption for the root device";

    name = lib.mkOption {
      type = lib.types.str;
      default = "cryptroot";
      description = "device-mapper name the decrypted root device is exposed as (/dev/mapper/<name>)";
    };

    device = lib.mkOption {
      type = lib.types.str;
      description = "the LUKS-encrypted block device, by-uuid (e.g. /dev/disk/by-uuid/xxxxxxxx-...)";
    };

    tpm.enable = lib.mkEnableOption "unlock via TPM2 (systemd-cryptenroll) with automatic passphrase fallback";
  };

  config = lib.mkIf config.luks.enable {
    # TPM2 auto-unlock happens inside the initrd, which requires the
    # systemd-based initrd stage instead of the default script-based one.
    boot.initrd.systemd.enable = true;

    boot.initrd.luks.devices.${config.luks.name} = {
      device = config.luks.device;
      crypttabExtraOpts = lib.mkIf config.luks.tpm.enable [ "tpm2-device=auto" ];
    };
  };
}
