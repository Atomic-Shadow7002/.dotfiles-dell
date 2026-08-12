{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/luks.nix
    ../../modules/hosts/common-settings.nix
    ../../modules/hosts/trusted-substituters.nix
    ../../modules/hosts/security.nix
    ../../modules/hosts/netmod.nix
    ../../modules/hosts/bluetooth.nix
    ../../modules/hosts/pipewire.nix
    ../../modules/hosts/graphics.nix
    ../../modules/hosts/podman.nix
    ../../modules/hosts/vm.nix
    ../../modules/hosts/sunshine.nix
    ../../modules/hosts/android.nix
    ../../modules/hosts/power.nix
    ../../modules/hosts/gaming.nix
  ];

  # Some stuff that should exist independently.
  system.stateVersion = "25.05";
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  boot.tmp.cleanOnBoot = true;

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.fileSystems = [ "/" ];
  services.btrfs.autoScrub.interval = "weekly";
  services.gvfs.enable = true;

  # Firmware stuff.
  services.fwupd.enable = true;

  # Laptop lid config. Unlike a docked desktop-replacement setup, this
  # actually leaves the house -- suspend on lid close unless something has
  # genuinely docked it (external display attached), so it doesn't cook
  # itself in a bag.
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "suspend";
  };

  # Fine-grained boot stuff.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  # `linuxPackages`, not `_latest`: a brand-new kernel paired with the
  # proprietary nvidia driver is exactly where hybrid-graphics laptops tend
  # to break for a few days after every kernel bump.
  boot.kernelPackages = pkgs.linuxPackages;

  # Zram stuff.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  # systemd OOMD
  systemd.oomd = {
    enable = true;
    enableRootSlice = true;
    enableUserSlices = true;
  };

  boot.kernelParams = [
    "iommu=pt"
    "idle=nomwait"
  ];

  # Fine-grained localization stuff.
  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Miscellaneous stuff.
  common-settings.enable = true;
  common-settings.flake = "/home/atomic-shadow/.dotfiles";
  common-settings.gc.options = "--delete-older-than 7d";
  trusted-substituters.enable = true;
  security.enable = true;

  # Disk encryption. Run `systemd-cryptenroll` once after first boot to add
  # the TPM key slot -- see PARTITIONING.md.
  # luks.enable = true;
  # luks.tpm.enable = true;
  # luks.device = "/dev/disk/by-uuid/REPLACE-ME-LUKS-PARTITION-UUID";

  # Networking stuff.
  netmod.enable = true;
  netmod.name = "nixos";

  # Media stuff.
  bluetooth.enable = true;
  pipewire.enable = true;

  # Desktop session. Both are available; pick your session at the login
  # manager. (Previously these were unconditionally on with no toggle at
  # all -- now they're regular options like everything else.)
  wm.niri.enable = true;
  wm.plasma.enable = true;

  # Graphics. Intel 10th/11th-gen iGPU + Ampere (RTX 30-series) dGPU,
  # PRIME offload by default with a "sync" specialisation available for
  # when you're docked with an external monitor going full send.
  graphics.enable = true;
  graphics.intel.enable = true;
  graphics.nvidia.enable = true;
  graphics.nvidia.prime.enable = true;
  graphics.nvidia.prime.mode = "offload";
  # REPLACE with your actual bus ids: boot once, run
  #   nix shell nixpkgs#pciutils -c lspci -D -d ::03xx
  # then convert hex bus/device/function to decimal, format as PCI:B@D:d:f.
  graphics.nvidia.prime.intelBusId = "PCI:0@0:2:0";
  graphics.nvidia.prime.nvidiaBusId = "PCI:1@0:0:0";

  # Boot into this specialisation (or `nixos-rebuild switch --specialisation
  # sync`) when docked with an external monitor for full dGPU performance.
  specialisation.sync.configuration = {
    graphics.nvidia.prime.mode = lib.mkForce "sync";
  };

  # Power management.
  power.enable = true;

  # Gaming.
  gaming.enable = true;

  # Virtualization stuff.
  podman.enable = true;
  vm.enable = true;
  vm.kvm.enable = true;
  # vm.waydroid.enable = true;

  # Sunshine (and Moonlight) stuff.
  sunshine.enable = true;

  # Flatpak stuff.
  services.flatpak.enable = true;

  # AppImage stuff.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.libxcrypt
      pkgs.icu
    ];
  };

  # Nix-ld.
  programs.nix-ld.enable = true;

  # OpenSSH
  services.openssh.enable = true;

  # Android
  android.enable = true;

  # Printing + Scanning
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  # Fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.caskaydia-cove
      pkgs.maple-mono.NF
    ];
  };

  # Shell. home-manager configures fish's actual behaviour, but the login
  # shell itself and its /etc/shells registration are a system-level concern.
  programs.fish.enable = true;

  # Me!
  users.users.atomic-shadow = {
    isNormalUser = true;
    description = "Atomic Shadow";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "bluetooth"
      "libvirtd"
      "kvm"
      "adbusers"
    ];
  };

  # Variables stuff.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ZED_WINDOW_DECORATIONS = "server";
    SIGNAL_PASSWORD_STORE = "kwallet6";
  };
}
