{ config, pkgs, mySecrets, ... }:

{
  programs.aria2 = {
    enable = true;

    settings = {
      dir = "${config.home.homeDirectory}/Downloads"; 
      continue = true;                               # 开启断点续传
      max-concurrent-downloads = 5;                  # 同时下载的最大任务数
      max-connection-per-server = 16;                # 单个服务器最大连接数
      min-split-size = "10M";                        # 文件分段大小
      split = 16;                                    # 单个任务的最大分段/线程数
      
      # --- RPC 远程控制 ---
      enable-rpc = true;                             # 开启 RPC 服务
      rpc-listen-all = false;                        # 仅允许本机连接
      rpc-listen-port = 6800;                        # RPC 监听端口
       
      # --- 性能与磁盘优化 ---
      file-allocation = "falloc";                    # 磁盘空间预分配方式
      disk-cache = "64M";                            # 内存磁盘缓存
      
      # --- BT / P2P 下载扩展 ---
      follow-torrent = true;                         # 自动开始下载种子文件
      listen-port = "6881-6999";                     # BT 监听端口范围
      dht-file-path = "${config.home.homeDirectory}/.cache/aria2/dht.dat"; # DHT 数据保存路径

    };
  };

  systemd.user.services.aria2 = {
    Unit = {
      Description = "Aria2 Downloader (Home Manager)";
      After = [ "network.target" "agenix.service" ];
    };
    Service = {
      ExecStartPre = pkgs.writeShellScript "aria2-prestart" ''
        conf="${config.xdg.configHome}/aria2/aria2.conf"
        tmpconf=$(mktemp)
        cp "$conf" "$tmpconf"
        echo "rpc-secret=$(cat ${mySecrets.getPath "aria2-rpc-secret"})" >> "$tmpconf"
        mkdir -p ${config.xdg.configHome}/aria2 "$(dirname ${config.home.homeDirectory}/.cache/aria2/dht.dat)"
        cp "$tmpconf" ${config.xdg.configHome}/aria2/aria2-runtime.conf
        chmod 600 ${config.xdg.configHome}/aria2/aria2-runtime.conf
      '';

      ExecStart = "${pkgs.aria2}/bin/aria2c --conf-path=${config.xdg.configHome}/aria2/aria2-runtime.conf";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
