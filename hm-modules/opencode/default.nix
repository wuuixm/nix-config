{ pkgs, ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      model = "deepseek/deepseek-chat";
      autoshare = false;
      autoupdate = false;
    };

    tui = {
      theme = "system";
      keybinds = {
        leader = "alt+b";
      };
    };

    context = ''
    '';
  };
}
