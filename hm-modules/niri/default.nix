{ config, pkgs, lib, ... }:

{
  home.file.".config/niri" = {
    source = ./rawConfig;
    recursive = true;
  };
}
