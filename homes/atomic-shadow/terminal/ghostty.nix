{
  programs.ghostty = {
    enable = true;

    settings = {
      theme = "dankcolors";

      command = "fish";
      shell-integration = "fish";

      window-decoration = "server";
      window-padding-x = 12;
      window-padding-y = "0,0";

      font-family = "Maple Mono NF";
      font-size = 18;
      font-feature = "-calt, -liga, -dlig";
    };
  };
}
