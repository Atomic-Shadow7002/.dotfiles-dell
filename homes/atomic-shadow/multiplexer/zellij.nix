# FIX: the real config (this file's `config.kdl`, with theme_dir wired to
# matugen's dynamic theme output, the catppuccin theme, and the full custom
# keybind set) used to sit on disk completely unreferenced. What was actually
# active was a 6-line inline stub that didn't set theme_dir at all -- so the
# dynamic theming pipeline for zellij was silently never applied.
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/themes/catppuccin.kdl".source = ./themes/catppuccin.kdl;
  xdg.configFile."zellij/themes/catppuccin.yaml".source = ./themes/catppuccin.yaml;
}
