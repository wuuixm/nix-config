{ config, pkgs, ... }:

{
  programs.yazi = {
    enable = true;

    flavors = {
      "rose-pine-moon" = pkgs.fetchFromGitHub {
        owner = "Mintass";
        repo = "rose-pine-moon.yazi";
        rev = "main";
        hash = "sha256-cImOSHFqSEz+V6ZKMSO3mYhSzdGCCwP74P6p3BhfLaQ=";
      };
    };

    theme = {
      flavor = {
        dark  = "rose-pine-moon";
        light = "rose-pine-moon";
      };
    };
  };
}
