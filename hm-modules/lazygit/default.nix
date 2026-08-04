
{ config, pkgs, ... }:

{
  programs.lazygit = {
    enable = true;

    settings = {
      gui = {
        showIcons = true; 
        sidePanelWidth = 0.33; 
        theme = {
          activeBorderColor = [ "#89b4fa" "bold" ]; 
          selectedLineBgColor = [ "#313244" ];
        };
      };

      git = {
        pagers = [
          {
            pager = "${pkgs.delta}/bin/delta --dark --paging=never";
            colorArg = "always";
          }
        ];
      };

      customCommands = [
        {
          key = "C";
          command = "git commit -v";
          context = "global";
          description = "commit with verbose diff";
          output = "terminal";
        }
      ];
    };
  };
}
