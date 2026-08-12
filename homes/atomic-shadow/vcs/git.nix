{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = "Abhishek Kumar Ray";
      user.email = "atomic7002@gmail.com";
      init.defaultBranch = "main";
      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@gitlab.com:".insteadOf = "gl:";
        "git@codeberg.org:".insteadOf = "cb:";
      };
      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = true;
      };
    };
  };
}
