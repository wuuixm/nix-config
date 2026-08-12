{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      # theme = "Catppuccin Frappe";
      # theme = "Violet Dark";
      theme = "Xcode Dark";
      # theme = "Rose Pine Moon";
      # theme = "Matugen";

      background-opacity = 0.7;
      window-decoration = "none";
      window-padding-x = 10;
      window-padding-y = 10;
      font-family = "Maple Mono NF CN";
      font-size = 12;
      confirm-close-surface = false;
      scrollback-limit = 5000;

      custom-shader = "${./shaders/cursor_smear.glsl}";
      # custom-shader = "${./shaders/starfield.glsl}";

      keybind = [
        "ctrl+j=scroll_page_lines:1"
        "ctrl+k=scroll_page_lines:-1"
        "ctrl+shift+j=scroll_page_down"
        "ctrl+shift+k=scroll_page_up"
        "ctrl+shift+h=jump_to_prompt:-1"
        "ctrl+shift+l=jump_to_prompt:1"
        "ctrl+shift+a=select_all"
      ];
    };
  };
}
