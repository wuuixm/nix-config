{ pkgs, lib, config, ... }:

let
  # 从 Windows 拷贝的中文字体（宋体/黑体/楷体/仿宋/微软雅黑等），仅供 WPS 使用。
  # 该目录已加入 .gitignore（不入库、不上传 github），flake 源树中不包含它，
  fontDir = "${config.home.homeDirectory}/nixos-Gardenia/hm-modules/wps/win-fonts";

  winFontSrc =
    if builtins.pathExists fontDir
    then builtins.path { path = fontDir; name = "wps-win-zh-fonts-src"; }
    else null;

  winZhFonts = pkgs.runCommand "wps-win-zh-fonts" { } (
    (lib.optionalString (winFontSrc != null) ''
      mkdir -p $out/share/fonts/truetype/win-zh
      find ${winFontSrc} -type f \( -iname '*.ttf' -o -iname '*.ttc' -o -iname '*.otf' \) -exec cp {} $out/share/fonts/truetype/win-zh/ \;
    '')
    + (lib.optionalString (winFontSrc == null) ''
      mkdir -p $out
    '')
  );
in
{
  home.packages = with pkgs; [
    wpsoffice-cn
    winZhFonts
  ];
}
