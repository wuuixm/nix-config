{ config, pkgs, inputs, mySecrets, ... }:

let
  entries = builtins.readDir ./.;
  allNames = builtins.attrNames entries;
  dirNames = builtins.filter (name: entries.${name} == "directory") allNames;
  autoImports = map (dir: ./. + "/${dir}") dirNames;
in
{
  # 导入子模块
  imports = autoImports;

  # 用户基础信息
  home.username = "wuuixm";
  home.homeDirectory = "/home/wuuixm";

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "/home/wuuixm/Desktop";
    download = "/home/wuuixm/Downloads";
    documents = "/home/wuuixm/Documents";
    music = "/home/wuuixm/Music";
    pictures = "/home/wuuixm/Pictures";
    videos = "/home/wuuixm/Videos";
    templates = "/home/wuuixm/Templates";
    publicShare = "/home/wuuixm/Public";
  };

  # 用户服务
  services.ssh-agent.enable = true;

  services.udiskie = {
    enable = true;
    tray = "auto";
  };


  # 用户软件包
  home.packages = with pkgs; [
    wineWow64Packages.stableFull
    winetricks
    gnumake
    python3
    clang-tools
    splayer
    ffmpeg
    hmcl
    evtest
    wl-clipboard
    cliphist
    polkit_gnome
    fd
    jq
    chafa
    ouch
    dust
    sd
    fzf
    ripgrep
    manix
    fastfetch
    google-chrome
    inputs.helium.packages.${pkgs.system}.default
    mpv
    imv
    wl-screenrec
    slurp
    uv
    mdcat
    docker-compose
    gcc
    binutils
  ];

  # 简单模块
  programs.bat.enable = true;
  programs.lsd = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };


  # 环境变量
  home.sessionVariables = {
    LANGUAGE = "zh_CN:en_US";
    LC_MESSAGES = "en_US.UTF-8";

    # EDITOR = "nvim";
    # VISUAL = "nvim";
    
    EDITOR = "hx";
    VISUAL = "hx";

    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE  = "fcitx";
    XMODIFIERS    = "@im=fcitx";
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
  ];

  # Home Manager 自身
  programs.home-manager.enable = true;
  home.stateVersion = "26.05";
}
