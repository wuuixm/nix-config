{ pkgs, lib, ... }:

{
  home.packages = [ pkgs.matugen ];

  home.file = {
    ".config/matugen/config.toml".source = ./config.toml;
    ".config/matugen/templates" = {
      source = ./templates;
      recursive = true;
    };
  };

  home.activation.createMatugenOutputs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/matugen/outputs"
  '';
}