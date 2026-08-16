{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.nodejs
    pkgs.pnpm
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"

    "${config.home.homeDirectory}/.local/share/pnpm"
    "${config.home.homeDirectory}/.local/share/pnpm/bin"
  ];

  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm-global
  '';

  home.file.".config/pnpm/rc".text = ''
    global-bin-dir=${config.home.homeDirectory}/.local/share/pnpm/bin
    global-dir=${config.home.homeDirectory}/.local/share/pnpm/global
  '';
}
