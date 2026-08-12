{
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      {
        appId = "com.usebottles.bottles";
        origin = "flathub";
      }
    ];
    update.auto.enable = true;
    update.auto.onCalendar = "daily";
  };
}
