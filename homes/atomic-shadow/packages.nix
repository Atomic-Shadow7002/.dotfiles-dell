{ pkgs, ... }:

{
  home.packages = [
    # themes and icons
    (pkgs.catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
      winDecStyles = [ "classic" ];
    })
    pkgs.android-studio
    pkgs.antigravity-ide
    pkgs.bibata-cursors
    pkgs.brave
    pkgs.blender
    pkgs.codebook
    pkgs.deno
    pkgs.distrobox
    pkgs.fd
    pkgs.ferium
    pkgs.ffmpeg
    pkgs.fish-lsp
    pkgs.gcc
    pkgs.gnumake
    pkgs.gradle
    pkgs.gtk3
    pkgs.inotify-tools
    pkgs.jq
    pkgs.just
    pkgs.kdePackages.karousel
    pkgs.kdePackages.kconfig
    pkgs.kdePackages.kde-gtk-config
    pkgs.krita
    pkgs.lazyjj
    pkgs.legcord
    pkgs.libreoffice-qt-fresh
    pkgs.lsof
    pkgs.maple-mono.NF
    pkgs.markdown-oxide
    pkgs.maven
    pkgs.mpv
    pkgs.ngrok
    pkgs.nix-output-monitor
    pkgs.nix-search-tv
    pkgs.nixd
    pkgs.nixfmt
    pkgs.noto-fonts-cjk-sans
    pkgs.nodejs
    pkgs.nvd
    pkgs.openjdk21
    pkgs.papirus-folders
    pkgs.pear-desktop
    pkgs.protonup-ng
    pkgs.protonup-qt
    pkgs.podman-compose
    (pkgs.postman.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        wrapProgram $out/bin/postman \
          --add-flags "--disable-gpu" \
          --add-flags "--disable-features=WaylandWindowDecorations"
      '';
    }))
    (pkgs.prismlauncher.override {
      jdks = [ pkgs.jdk25 ];
    })
    pkgs.quickemu
    pkgs.ripgrep
    pkgs.ripgrep-all
    pkgs.rustdesk-flutter
    pkgs.scrcpy
    pkgs.simple-completion-language-server
    pkgs.sunshine
    pkgs.taplo
    pkgs.telegram-desktop
    pkgs.tinymist
    pkgs.typst
    pkgs.typstyle
    pkgs.unrar
    pkgs.vlc
    pkgs.vscode
    pkgs.vscode-langservers-extracted
    pkgs.wl-clipboard
    pkgs.wl-mirror
    pkgs.yaml-language-server
    pkgs.zathura
    pkgs.zed-editor-fhs
  ];
}
