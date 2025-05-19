# 用户软件包模块 - 用户级软件包配置
{ config, pkgs, ... }:

{
  # 用户级软件包
  home.packages = with pkgs; [
    # 终端工具
    fastfetch
    nnn           # 终端文件管理器
    neovim
    
    # 开发工具
    gcc
    binutils
    gnumake
    cmake
    verilator
    
    # 压缩/解压工具
    zip
    xz
    unzip
    p7zip

    # 实用工具
    ripgrep       # 递归搜索文件内容的正则表达式模式
    jq            # 轻量级灵活的命令行JSON处理器
    yq-go         # YAML处理工具 https://github.com/mikefarah/yq
    eza           # 'ls'的现代替代品
    fzf           # 命令行模糊查找器

    # 杂项
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # Nix相关工具
    nix-output-monitor  # 提供更详细的nix命令输出日志

    # 生产力工具
    glow            # 终端中的Markdown预览工具
    btop            # htop/nmon的替代品

    # 系统调用监控
    strace
  ];
}
