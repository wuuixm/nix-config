{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin-blur"
      "fish"
      "html"
      "json5"
      "nix"
      "sql"
      "syntaqlite-lsp"
      "toml"
      "vue"
    ];

    userSettings = {
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };
      project_panel = {
        dock = "left";
      };
      git_panel = {
        dock = "left";
      };
      agent = {
        default_model = {
          provider = "deepseek";
          model = "deepseek-v4-flash";
          enable_thinking = true;
          effort = "high";
        };
        dock = "right";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
      ui_font_family = "Maple Mono NF CN";
      buffer_font_family = "Maple Mono NF CN";
      ui_font_size = 16;
      buffer_font_size = 15;
      theme = "Catppuccin Frappé (Blur) [Light]";
    };

    userKeymaps = [
      {
        context = "vim_mode == insert";
        bindings = {
          "j j" = "vim::NormalBefore";
        };
      }
    ];
  };
}
