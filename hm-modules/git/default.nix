{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "wuuixm";
        email = "wuuixm@outlook.com";
      };
      credential = {
        "https://github.com".helper = "!f() { echo \"username=oauth2\"; echo \"password=$GITHUB_TOKEN\"; }; f";
      };
    };
  };
}
