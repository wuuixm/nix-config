{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;  

    settings = {
      theme = "catppuccin_frappe";

      editor = {
        indent-guides = {
          render = true;
          character = "│";      
          rainbow-option = "normal"; 
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        line-number = "relative";
        cursorline = true;
        color-modes = true;

      };

      keys = {

        normal = {
          "L" = ":sh ghostty -e lazygit > /dev/null 2>&1 &";
          "H" = ":sh cd \"$(dirname \"%{buffer_name}\")\" && ghostty -e opencode > /dev/null 2>&1 &";
        };

        insert = {
          "j" = { "j" = "normal_mode"; };
        };
      };

    };
  };

  home.packages = [
    (pkgs.runCommand "helix-hx-alias" { } ''
      mkdir -p $out/bin
      ln -s ${pkgs.evil-helix}/bin/hx $out/bin/helix
    '')
  ];
}
