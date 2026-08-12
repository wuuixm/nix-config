{ inputs, pkgs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      # ---------- backdrop ----------
      backdrop = {
        enabled = true;
      };

      # ---------- bar ----------
      bar.default = {
        background_opacity = 0.0;
        capsule = true;
        capsule_fill = "tertiary";
        capsule_foreground = "on_tertiary";
        capsule_opacity = 0.65;
        center = [ "group:g1" "cat" ];
        concave_edge_corners = false;
        end = [ "tray" "network" "bluetooth" "volume" "brightness" "battery" "group:g2" ];
        margin_ends = 0;
        padding = 8;
        start = [ "workspaces" "audio_visualizer" "privacy" "media" "active_window" "screen-toolkit" ];

        capsule_group = [
          {
            enabled = true;
            fill = "tertiary";
            foreground = "on_tertiary";
            id = "g1";
            members = [ "weather" "clock" ];
            opacity = 0.65;
            padding = 6.0;
          }
          {
            enabled = true;
            fill = "tertiary";
            foreground = "on_tertiary";
            id = "g2";
            members = [ "notifications" "control-center" ];
            opacity = 0.65;
            padding = 6.0;
          }
        ];
      };

      # ---------- desktop widgets ----------
      desktop_widgets = {
        enabled = false;
      };

      # ---------- location ----------
      location = {
        address = "chuzhou";
      };

      # ---------- lockscreen widgets ----------
      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@eDP-1"
          "lockscreen-login-box@eDP-2"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000003"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget = {
          "lockscreen-login-box@eDP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 854.0;
            cy = 841.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
            };
          };

          "lockscreen-login-box@eDP-2" = {
            box_height = 64.0;
            box_width = 384.0;
            cx = 853.5;
            cy = 646.0;
            output = "eDP-2";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "secondary";
              background_opacity = 0.48;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = false;
            };
          };

          "lockscreen-widget-0000000000000001" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 853.5;
            cy = 480.0;
            output = "eDP-2";
            rotation = 0.0;
            type = "fancy_audio_visualizer";
            settings = {
              background = false;
              background_color = "error";
              primary_color = "primary";
              secondary_color = "tertiary";
              visualization_mode = "all";
            };
          };

          "lockscreen-widget-0000000000000003" = {
            box_height = 80.0;
            box_width = 624.0;
            cx = 853.5;
            cy = 215.0;
            output = "eDP-2";
            rotation = 0.0;
            type = "clock";
            settings = {
              background = false;
              background_color = "surface";
              background_opacity = 0.8;
              background_padding = 10;
              background_radius = 12;
              center_text = true;
              circle = true;
              clock_style = "digital";
              color = "primary";
              font_family = "";
              format = "{:%Y-%m-%d %H:%M:%S}";
              shadow = true;
              timezone = "";
            };
          };
        };
      };

      # ---------- notification ----------
      notification = {
        layer = "overlay";
      };

      # ---------- OSD ----------
      osd = {
        position = "top_right";
      };

      # ---------- plugin settings ----------
      plugins = {
        enabled = [ "noctalia/bongocat" "alexander/screen-toolkit" ];
      };

      # ---------- plugin_settings ----------
      plugin_settings = {
        "alexander/screen-toolkit" = {
          selected-ocr-lang = "eng+chi_sim";
        };
      };

      # ---------- shell ----------
      shell = {
        app_icon_color = "on_hover";
        clipboard_auto_paste = "off";
        clipboard_history_max_entries = 300;
        font_family = "Noto Serif CJK SC";
        lang = "zh-Hans";
        panel_anchor_bar = "default";
        password_style = "random";
        polkit_agent = true;

        panel = {
          control_center_placement = "floating";
          open_near_click_control_center = true;
          session_placement = "floating";
          transparency_mode = "soft";
          wallpaper_placement = "floating";
        };

        screenshot = {
          confirm_region = true;
          copy_to_clipboard = false;
          pipe_command = "satty -f -";
          pipe_to_command = true;
          save_to_file = false;
        };
      };

      # ---------- theme ----------
      theme = {
        builtin = "Dracula";
        community_palette = "Oxocarbon";
        mode = "light";
        source = "wallpaper";
        wallpaper_scheme = "soft";
        templates = {
          enable_builtin_templates = false;
          enable_community_templates = false;
        };
      };

# ---------- hooks ----------
      hooks = {
        wallpaper_changed = ''matugen image "$NOCTALIA_WALLPAPER_PATH" -m dark --source-color-index 0'';
      };

      # ---------- widgets ----------
      widget = {
        audio_visualizer = {
          bands = 24;
          color_2 = "on_primary";
          mirrored = false;
          show_when_idle = true;
          width = 100;
        };
        cat = {
          input_devices = [ "/dev/input/by-id/*-event-kbd" "/dev/input/by-id/*-event-mouse" ];
          rave_mode = true;
          type = "noctalia/bongocat:cat";
        };
        clock = {
          format = "{:%m-%d %H:%M}";
        };
        "control-center" = {
          glyph = "snowflake";
        };
        media = {
          hide_when_no_media = true;
          max_length = 150;
          title_scroll = "on_hover";
        };
        privacy = {
          hide_inactive = true;
        };
        tray = {
          detached_panel = true;
          drawer = true;
          pinned = [ "tray-icon tray app main" "tray-icon tray app clash-verge-rev-tray" ];
        };
        weather = {
          max_length = 220;
        };
      };
    };
  };
}
