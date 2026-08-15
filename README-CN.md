# Gardenia NixOS 配置

[**English Version**](README.md)

基于 Flakes 构建，集成 Home Manager 管理用户环境，使用 agenix 处理加密密钥，在 ASUS ROG 笔记本（AMD 核显 + NVIDIA Prime）上采用混合桌面方案（niri + Noctalia + COSMIC）。

![fastfetch](https://github.com/wuuixm/img-bed/blob/main/nixos/fastfetch.png)

## 项目结构

```
├── flake.nix                      # 入口，定义 Gardenia 配置及依赖
│                                  # （substituters：中科大/清华镜像 + cache.nixos.org）
├── flake.lock                     # 锁定依赖版本，确保可复现
├── hardware-configuration.nix     # nixos-generate-config 自动生成的硬件配置
│
├── os-modules/                    # NixOS 系统模块（readDir 自动导入子目录）
│   ├── boot/                      # GRUB（EFI + Cryptodisk + os-prober）、内核参数、zram
│   ├── desktop/                   # COSMIC + niri、Ly 显示管理器、Portal、控制台字体
│   ├── hardware/                  # PipeWire、NVIDIA Prime（supergfxd）、asusd、蓝牙
│   ├── locale/                    # 主机名、时区、语言、fcitx5（RIME）输入法、字体
│   ├── nix/                       # Flakes 配置、nix-ld、每周垃圾回收、Nix 优化、allowUnfree
│   ├── services/                  # SSH、NetworkManager、Flatpak、Steam、Docker、Clash Verge
│   ├── users/                     # 用户 wuuixm 定义（fish shell）
│   └── virtualisation/            # libvirtd + virt-manager
│
├── hm-modules/                    # Home Manager 模块（readDir 自动导入子目录）
│   ├── default.nix                # 入口：用户名、XDG 目录、环境变量、基础软件包与服务
│   ├── agenix/                    # 密钥管理（aria2-rpc-secret, github-token）
│   ├── aria2/                     # Aria2 下载器（systemd 用户服务，RPC :6800）
│   ├── btop/                      # btop 系统监视器
│   ├── evil-helix/                # Helix 编辑器（evil-helix vim 分支）
│   ├── fastfetch/                 # 系统信息显示（自动选择 logo、自定义边框）
│   ├── fish/                      # Fish 终端（vi 模式、自动生成 i<模块名> 缩写）
│   ├── ghostty/                   # Ghostty 终端模拟器（自定义 GLSL 着色器、Matugen 主题）
│   ├── git/                       # Git 配置（GitHub OAuth，GITHUB_TOKEN）
│   ├── lazygit/                   # LazyGit TUI 客户端（delta diff 分页）
│   ├── matugen/                   # Material 配色生成器（niri/ghostty 动态主题）
│   ├── neovim/                    # Neovim 编辑器（oil.nvim, fzf-lua, mini.pairs, catppuccin）
│   ├── niri/                      # niri 合成器原始 KDL 配置
│   ├── noctalia/                  # Noctalia 桌面 shell（顶栏、锁屏组件、bongocat）
│   │                              #  – 壁纸切换时驱动 matugen 生成主题
│   ├── opencode/                  # OpenCode AI 编程助手（DeepSeek）
│   ├── rime/                      # RIME（fcitx5）双拼输入方案
│   ├── rust/                      # rust-overlay 提供的 Rust 工具链（rust-analyzer, rust-src）
│   ├── starship/                  # Starship 终端提示符（自定义配色）
│   ├── tealdeer/                  # tealdeer（命令速查手册）
│   ├── wps/                       # WPS Office（Windows 中文字体，gitignored 不入库）
│   ├── yazi/                      # Yazi 终端文件管理器（rose-pine-moon）
│   └── zed/                       # Zed 编辑器（catppuccin、DeepSeek 智能体）
│
├── tools/
│   └── edit-password              # agenix 密钥交互管理工具（Python polyglot）
```

## 使用方法

### 前置要求

- 已启用 Flakes 的 NixOS
- `~/.ssh/id_ed25519` SSH 密钥（作为 agenix 身份密钥）
- 首次切换前先运行 `./tools/edit-password` 生成 age 密钥

### 系统切换

```bash
# 切换系统（主机名：Gardenia）
# --impure 是必须的：WPS 字体已被 gitignore，需经 builtins.path 从磁盘读取，
# 而纯求值模式下禁止该操作（详见下方小贴士）。
sudo nixos-rebuild switch --impure --flake ~/nixos-Gardenia#Gardenia

# 更新所有 flake 输入
nix flake update --flake ~/nixos-Gardenia
```

Fish 已提供对应缩写（见 `hm-modules/fish/default.nix`）：

| 缩写 | 命令 |
|------|------|
| `rd` | `sudo nixos-rebuild switch --impure --flake ~/nixos-Gardenia#Gardenia` |
| `upd` | `nix flake update --flake ~/nixos-Gardenia` |
| `gc` | `nix-collect-garbage -d && sudo nix-collect-garbage -d` |
| `ips` | `~/nixos-Gardenia/tools/edit-password` |
| `ifk` / `ihm` / `ish` | 用 `$EDITOR` 打开 `flake.nix` / `hm-modules/default.nix` / fish 配置 |
| `i<模块名>` | 打开任意 hm 模块配置（为每个模块自动生成） |
| `nrs` / `zed` / `bp` / `ff` | `niri-session` / `zeditor` / `btop` / `fastfetch` |

## 软件清单

### Home Manager – 用户软件包

| 软件包 | 说明 |
|--------|------|
| [clang-tools](https://clang.llvm.org/) | C/C++ LSP（clangd）及工具 |
| [splayer](https://github.com/chiflix/splayerx) | 在线流媒体播放器 |
| [hmcl](https://hmcl.huangyuhui.net/) | Hello Minecraft! 启动器 |
| [evtest](https://cgit.freedesktop.org/evtest/) | 输入事件调试工具 |
| [wl-clipboard](https://github.com/bugaevc/wl-clipboard) | Wayland 剪贴板工具 |
| [cliphist](https://github.com/sentriz/cliphist) | Wayland 剪贴板历史 |
| [polkit_gnome](https://gitlab.freedesktop.org/PolicyKit/polkit) | 授权认证代理 |
| [fd](https://github.com/sharkdp/fd) | 文件快速搜索（Rust） |
| [jq](https://jqlang.github.io/jq/) | JSON 处理器 |
| [chafa](https://hpjansson.org/chafa/) | 图片转 ASCII 工具 |
| [ouch](https://github.com/ouch-org/ouch) | 归档压缩工具（Rust） |
| [dust](https://github.com/bootandy/dust) | 磁盘空间分析（Rust） |
| [sd](https://github.com/chmln/sd) | sed 替代工具（Rust） |
| [fzf](https://github.com/junegunn/fzf) | 模糊搜索工具 |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | 代码搜索工具（Rust） |
| [manix](https://github.com/mlvzk/manix) | Nix 文档搜索 |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | 系统信息显示 |
| [google-chrome](https://www.google.com/chrome/) | 网页浏览器 |
| [Helium](https://github.com/schembriaiden/helium-browser-nix-flake) | 极简浏览器（flake 输入） |
| [WPS Office](https://www.wps.com/) | 办公套件（中文字体来自 Windows，gitignored 不入库） |
| [mpv](https://mpv.io/) | 媒体播放器 |
| [imv](https://sr.ht/~exec64/imv/) | 图片查看器（Wayland） |
| [wl-screenrec](https://github.com/russelltg/wl-screenrec) | Wayland 屏幕录制（Rust） |
| [slurp](https://github.com/emersion/slurp) | Wayland 区域选择工具（Rust） |
| [uv](https://github.com/astral-sh/uv) | Python 包管理器（Rust） |
| [fnm](https://github.com/Schniz/fnm) | Node.js 版本管理器（Rust） |
| [mdcat](https://github.com/swsnr/mdcat) | Markdown 渲染器（Rust） |
| [docker-compose](https://github.com/docker/compose) | Docker 编排工具 |
| [gcc](https://gcc.gnu.org/) | C/C++ 编译器 |
| [binutils](https://www.gnu.org/software/binutils/) | 二进制工具集 |

### Home Manager – 已配置的程序与服务

| 程序 | 说明 |
|------|------|
| [bat](https://github.com/sharkdp/bat) | `cat` 替代，带语法高亮（Rust） |
| [lsd](https://github.com/lsd-rs/lsd) | `ls` 替代，带图标和颜色（Rust） |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | 智能目录跳转（Rust） |
| [btop](https://github.com/aristocratos/btop) | 系统资源监视器 |
| [Helix (evil-helix)](https://github.com/The-Devoy/evil-helix) | 模态编辑器（Helix vim 分支） |
| [Ghostty](https://ghostty.org/) | GPU 加速终端模拟器（自定义着色器、Matugen 主题） |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git TUI 客户端（delta 分页） |
| [matugen](https://github.com/InioX/matugen) | Material 配色生成器（niri/ghostty 动态主题） |
| [Neovim](https://neovim.io/) | 可扩展代码编辑器（catppuccin-mocha） |
| [Noctalia](https://github.com/noctalia-dev/noctalia) | COSMIC/niri 桌面 Shell（壁纸切换时触发 matugen） |
| [niri](https://github.com/YaLTeR/niri) | 滚动平铺 Wayland 合成器（Matugen 生成配色） |
| [Starship](https://starship.rs/) | 跨 Shell 提示符 |
| [tealdeer](https://github.com/tealdeer-rs/tealdeer) | 命令速查手册（Rust） |
| [Yazi](https://github.com/sxyazi/yazi) | 终端文件管理器（Rust，rose-pine-moon） |
| [Zed](https://zed.dev/) | 高性能代码编辑器（DeepSeek 智能体） |
| [OpenCode](https://opencode.ai) | AI 编程助手 CLI/TUI（DeepSeek） |
| Rust 工具链 | rust-overlay stable + rust-analyzer + rust-src |
| [satty](https://github.com/gabm/satty) | Wayland 截图工具（Noctalia 截图管道） |
| [Aria2](https://aria2.github.io/) | 下载管理器（systemd 用户服务，RPC :6800） |
| [udiskie](https://github.com/coldfix/udiskie) | 可移动介质自动挂载 |
| ssh-agent | SSH 密钥代理 |
| home-manager | Home Manager 程序 |

### 系统级别 – 软件包与服务

| 软件包 / 服务 | 说明 |
|---------------|------|
| [asusctl](https://gitlab.com/asus-linux/asusctl) | ASUS ROG 笔记本控制 |
| [Clash Verge](https://github.com/clash-verge-rev/clash-verge-rev) | 代理客户端（TUN + 服务模式，开机自启） |
| [Steam](https://store.steampowered.com/) | 游戏平台 |
| [Docker](https://www.docker.com/) | 容器运行时（Rootless） |
| [libvirtd](https://libvirt.org/) + [virt-manager](https://virt-manager.org/) | 虚拟机管理（QEMU/KVM + swtpm） |
| [Flatpak](https://flatpak.org/) | 通用包管理器 |
| [OpenSSH](https://www.openssh.com/) | 远程连接 |
| [NetworkManager](https://networkmanager.dev/) | 网络管理 |
| [PipeWire](https://pipewire.org/) | 音频系统（ALSA + PulseAudio，rtkit） |
| [NVIDIA Prime](https://wiki.archlinux.org/title/PRIME) | 双显卡切换（supergfxd，amdgpu + nvidia） |
| [fcitx5](https://github.com/fcitx/fcitx5) | 输入法框架（RIME + 双拼） |
| [GRUB](https://www.gnu.org/software/grub/) | 引导加载器（EFI + Cryptodisk + os-prober，crt-amber 主题） |
| [Ly](https://github.com/fairyglade/ly) | TUI 显示管理器（blackhole.dur 动画） |
| [xwayland-satellite](https://github.com/Supreeeme/xwayland-satellite) | Wayland 原生 XWayland |
| zramSwap | 压缩内存交换分区 |

## 工具

### edit-password

一个自包含的 Python polyglot 脚本，用于交互式管理 agenix 加密密钥，支持添加/编辑/删除公钥和密码，自动备份快照，误操作可一键回滚。

```bash
cd ./tools
./edit-password
```

## 小贴士

### Fish 自动生成缩写

`hm-modules/fish/default.nix` 遍历 `hm-modules` 下所有子目录，自动为每个模块生成 `i<模块名>` 缩写，一键用编辑器打开对应模块配置。

- `ifish` → 打开 fish 配置
- `igit` → 打开 git 配置
- `iniri` → 打开 niri 配置
- ……所有模块同理

### Auto-import 模块自动发现

`os-modules/default.nix` 和 `hm-modules/default.nix` 通过 `builtins.readDir` 自动导入所有子目录。新增模块只需创建目录，无需手动修改 imports。

### NixOS Secrets 统一管理

`tools/edit-password` 使用 polyglot 技巧（同一文件可同时作为 shell/python 运行），交互式管理 agenix 密钥，支持增删改查，自动备份快照，误操作可一键回滚。

### 为什么切换系统需要加 `--impure`

WPS 依赖真正的 Windows 中文字体（宋体/黑体/楷体/仿宋等）才能像 MS Word 一样渲染文档。这些是**专有字体**，因此**不提交**到本仓库：只存在于 `hm-modules/wps/win-fonts/`（已被 gitignore，不会 push 到 GitHub）。

Nix flakes 默认采用**纯求值（pure evaluation）**，只能看到 flake 源树里被 git 跟踪的文件。字体被 gitignore 后，构建便"看不见"它们。于是 `wps` 模块改用 `builtins.path` 直接从**磁盘绝对路径**读取字体目录——而纯求值禁止这一操作。加 `--impure` 即为这次求值解锁对本地路径的读取，字体才能被打包进用户环境。

内置了两层安全兜底：
- 若 `hm-modules/wps/win-fonts/` 不存在，或重建时**忘了加** `--impure`（此时 `builtins.pathExists` 返回 `false`），配置会退化为**空字体包**而不是报错崩溃——系统照常构建，只是缺少中文字体。
