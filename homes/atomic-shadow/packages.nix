{ pkgs, ... }:

{
  home.packages = [
    pkgs.android-studio
    pkgs.antigravity-ide
    pkgs.bibata-cursors
    pkgs.brave
    pkgs.blender
    pkgs.codebook
    pkgs.dconf
    pkgs.deno
    pkgs.distrobox
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fish-lsp
    pkgs.gradle
    pkgs.gtk3
    pkgs.inotify-tools
    pkgs.jq
    pkgs.just
    pkgs.lazyjj
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
    pkgs.pnpm
    pkgs.nvd
    pkgs.onlyoffice-desktopeditors
    pkgs.openjdk21
    pkgs.papirus-folders
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
    pkgs.quickemu
    pkgs.ripgrep
    pkgs.ripgrep-all
    pkgs.scrcpy
    pkgs.simple-completion-language-server
    pkgs.taplo
    pkgs.telegram-desktop
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
