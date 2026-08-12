{
  programs.jujutsu = {
    enable = true;
    ediff = true;
    settings = {
      user = {
        name = "Abhishek Kumar Ray";
        email = "atomic7002@gmail.com";
      };
      ui.default-command = "log";
      git.ignore-files = [ "lfs" ];
    };
  };
}
