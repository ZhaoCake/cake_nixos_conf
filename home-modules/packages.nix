# 用户软件包模块 - 核心通用工具包配置
{ config, pkgs, ... }:

{
  # 核心软件包 - 只包含通用的系统工具，开发环境分离到独立模块
  home.packages = with pkgs; [
    # 终端工具和编辑器
    fastfetch
    nnn           # 终端文件管理器
    neovim
    
    # 压缩/解压工具
    zip
    xz
    unzip
    p7zip

    # 文本处理和搜索工具
    ripgrep       # 递归搜索文件内容的正则表达式模式
    jq            # 轻量级灵活的命令行JSON处理器
    yq-go         # YAML处理工具 https://github.com/mikefarah/yq
    eza           # 'ls'的现代替代品
    fzf           # 命令行模糊查找器

    # 系统工具
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    
    # 系统监控和调试
    btop            # htop/nmon的替代品
    strace          # 系统调用监控

    # Nix相关工具
    nix-output-monitor  # 提供更详细的nix命令输出日志

    # 生产力工具
    glow            # 终端中的Markdown预览工具
    
    # 娱乐工具
    cowsay
  ];
}
