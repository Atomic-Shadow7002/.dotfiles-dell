{ pkgs, ... }:

let
  addons = pkgs.nur.repos.rycee.firefox-addons;
in
{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.atomic-shadow = {
      id = 0;
      isDefault = true;

      search = {
        force = true;
        default = "google";

        engines = {
          google = {
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://www.google.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@g" ];
          };

          "NixOS Search - Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages?channel=unstable&type=packages&query={searchTerms}";
              }
            ];
            icon = "https://wiki.nixos.org/nixos.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@np" ];
          };

          "NixOS Search - Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options?channel=unstable&type=packages&query={searchTerms}";
              }
            ];
            icon = "https://wiki.nixos.org/nixos.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@no" ];
          };

          "Home Manager - Option Search" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
              }
            ];
            icon = "https://home-manager-options.extranix.com/images/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@ho" ];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
              }
            ];
            icon = "https://wiki.nixos.org/nixos.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nw" ];
          };

          "AUR - Packages" = {
            urls = [
              {
                template = "https://aur.archlinux.org/packages?K={searchTerms}";
              }
            ];
            icon = "https://wiki.archlinux.org/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@aur" ];
          };

          "Arch Wiki" = {
            urls = [
              {
                template = "https://wiki.archlinux.org/index.php?search={searchTerms}";
              }
            ];
            icon = "https://wiki.archlinux.org/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@aw" ];
          };

          SearXNG = {
            urls = [
              {
                template = "https://search.inetol.net/search?q={searchTerms}";
              }
            ];
            icon = "https://search.inetol.net/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@sr" ];
          };
        };
      };

      extensions.packages = with addons; [
        bitwarden
        clearurls
        darkreader
        decentraleyes
        fastforwardteam
        firefox-color
        firefox-translations
        foxyproxy-standard
        foxytab
        privacy-badger
        pywalfox
        read-aloud
        sponsorblock
        stylus
        tablissng
        ublock-origin
        user-agent-string-switcher
        violentmonkey
        web-archives
      ];

      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;

      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
