{ pkgs, lib, ... }:

let

  # ================= 自动在./logo下寻找cur开头的文件 =================
  logoDir = ./logo;
  logoFiles = builtins.filter 
    (name: lib.hasPrefix "cur" name) 
    (builtins.attrNames (builtins.readDir logoDir));

  selectedLogo = if logoFiles != []
    then logoDir + "/${builtins.head logoFiles}"
    else logoDir + "/miku-pixel.txt";

  # ================= 自定义边框参数 =================
  boxWidth = 68; 

  repeatChar = char: count: lib.concatStrings (builtins.genList (_: char) count);

  makeTopBorder = title: color:
    let
      titleStr = " ${title} ";
      fillLen = boxWidth - (builtins.stringLength titleStr);
      leftLen = fillLen / 2;
      rightLen = fillLen - leftLen;
    in
    "{#${color}}┌${repeatChar "─" leftLen}${titleStr}${repeatChar "─" rightLen}┐{#default}";

  makeBottomBorder = color:
    "{#${color}}└${repeatChar "─" boxWidth}┘{#default}";

in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";

      logo = {
        type = "file";
        source = "${selectedLogo}";
      };

      display = {
        separator = "   ";
        key = {
          width = 16;
        };
      };

      modules = [
        /* ================= Title ================= */
        {
          type = "title";
          color = {
            user = "bright_cyan";
            at = "white";
            host = "bright_cyan";
          };
        }

        "break"

        /* ================= System ================= */
        { type = "custom"; format = makeTopBorder "System" "bright_blue"; }
        { type = "os";       key = "{#bright_blue}│  OS{#default}"; }
        { type = "host";     key = "{#bright_blue}│ 󰍹 Host{#default}"; }
        { type = "kernel";   key = "{#bright_blue}│  Kernel{#default}"; }
        { type = "uptime";   key = "{#bright_blue}│ 󰅐 Uptime{#default}"; }
        { type = "packages"; key = "{#bright_blue}│ 󰏖 Packages{#default}"; }
        { type = "custom"; format = makeBottomBorder "bright_blue"; }

        "break"

        /* ================= Desktop & Terminal ================= */
        { type = "custom"; format = makeTopBorder "Desktop & Terminal" "bright_magenta"; }
        { type = "de";       key = "{#bright_magenta}│ 󰧨 DE{#default}"; }
        { type = "wm";       key = "{#bright_magenta}│ 󰨇 WM{#default}"; }
        # { type = "display";  key = "{#bright_magenta}│ 󰍹 Display{#default}"; }
        { type = "shell";    key = "{#bright_magenta}│  Shell{#default}"; }
        { type = "terminal"; key = "{#bright_magenta}│ 󰞷 Terminal{#default}"; }
        { type = "custom"; format = makeBottomBorder "bright_magenta"; }

        "break"

        /* ================= Hardware  ================= */
        { type = "custom"; format = makeTopBorder "Hardware" "bright_yellow"; }
        { type = "cpu";    key = "{#bright_yellow}│ 󰍛 CPU{#default}"; }
        { type = "gpu";    key = "{#bright_yellow}│ 󰢮 GPU{#default}"; }
        { type = "memory"; key = "{#bright_yellow}│ 󰘚 Memory{#default}"; }
        { type = "swap";   key = "{#bright_yellow}│ 󰓡 swap{#default}"; }
        { type = "disk";   key = "{#bright_yellow}│ 󰋊 Disk{#default}"; }
        { type = "custom"; format = makeBottomBorder "bright_yellow"; }

        "break"

        /* ================= Network ================= */
        { type = "custom"; format = makeTopBorder "Network & Time" "bright_green"; }
        { type = "localip";   key = "{#bright_green}│ 󱦂 IP{#default}"; }
        { type = "wifi";      key = "{#bright_green}│ 󰀂 WiFi{#default}"; format = "{inf-desc}-{ssid}-{band} Ghz-{protocol}-{signal-quality}";}
        { type = "battery";   key = "{#bright_green}│ 󱈏 battery{#default}"; }
        { type = "local";     key = "{#bright_green}│ 󰒻 Local{#default}"; }
        { type = "custom"; format = makeBottomBorder "bright_green"; }

        "break"

        /* ================= 色块调色板 ================= */
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}
