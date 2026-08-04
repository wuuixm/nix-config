{ config, pkgs, ... }:

let

colors = {
  user   = "#9A348E"; # 紫色
  dir    = "#DA627D"; # 粉色
  git    = "#FCA17D"; # 橙色
  lang   = "#86BBD8"; # 天蓝色
  docker = "#06969A"; # 青绿色
  time   = "#33658A"; # 深蓝色
};

# colors = {
#     user   = "#2A9D8F"; # 松石绿
#     dir    = "#1D4E89"; # 海蓝色
#     git    = "#E76F51"; # 琥珀金
#     lang   = "#F43F5E"; # 鲜艳亮玫瑰粉
#     docker = "#E11D48"; # 郁深莓粉
#     time   = "#9F1239"; # 深沉夜玫粉
# };

in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format =
        "[](${colors.user})"
        + "$os"
        + "$username"
        + "[](bg:${colors.dir} fg:${colors.user})"
        + "$directory"
        + "[](fg:${colors.dir} bg:${colors.git})"
        + "$git_branch"
        + "$git_status"
        + "[](fg:${colors.git} bg:${colors.lang})"
        + "$c"
        + "$elixir"
        + "$elm"
        + "$golang"
        + "$gradle"
        + "$haskell"
        + "$java"
        + "$julia"
        + "$maven"
        + "$nodejs"
        + "$bun"
        + "$nim"
        + "$rust"
        + "$scala"
        + "[](fg:${colors.lang} bg:${colors.docker})"
        + "$docker_context"
        + "[](fg:${colors.docker} bg:${colors.time})"
        + "$time"
        + "[ ](fg:${colors.time})";

      username = {
        show_always = true;
        style_user = "bg:${colors.user}";
        style_root = "bg:${colors.user}";
        format = "[ $user ]($style)";
        disabled = false;
      };

      os = {
        style = "bg:${colors.user}";
        disabled = true;
      };

      directory = {
        style = "bg:${colors.dir}";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:${colors.git}";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:${colors.git}";
        format = "[$all_status$ahead_behind ]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      cpp = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      elixir = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      elm = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      golang = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      gradle = {
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      haskell = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      julia = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      maven = {
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      bun = {
        symbol = "";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      nim = {
        symbol = "󰆥 ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      scala = {
        symbol = " ";
        style = "bg:${colors.lang}";
        format = "[ $symbol ($version) ]($style)";
      };

      docker_context = {
        symbol = " ";
        style = "bg:${colors.docker}";
        format = "[ $symbol $context ]($style)";
      };

      time = {
        disabled = true;
        time_format = "%R";
        style = "bg:${colors.time}";
        format = "[ ♥ $time ]($style)";
      };
    };
  };
}
