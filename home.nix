# Home Manager配置入口
# 使用模块化设计，将不同功能分离到独立模块中
{ config, pkgs, ... }:
{
  # 用户名和主目录设置
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # 导入模块
  # 各模块分离不同功能，使配置更清晰、易于维护
  imports = [
    # 核心系统工具包
    ./home-modules/packages.nix
    # 开发环境模块（按需启用）
    ./home-modules/development.nix
    # Git配置
    ./home-modules/git.nix
    # Shell相关配置（如starship）  
    ./home-modules/shell.nix
  ];

  # 开发环境配置 - 根据需要启用
  # 取消注释以启用相应的开发环境
  development = {
    c-cpp.enable = true;      # C/C++ 开发环境
    # python.enable = true;   # Python 开发环境
    # nodejs.enable = true;   # Node.js 开发环境
    # rust.enable = true;     # Rust 开发环境
    hardware.enable = true;   # 硬件开发环境（Verilog等）
  };

  # Home Manager版本锁定
  # 这个值决定了你的配置与哪个Home Manager版本兼容
  # 有助于避免新版本引入向后不兼容的更改时出现问题
  home.stateVersion = "25.05";
  
  # 让Home Manager安装并管理自身
  programs.home-manager.enable = true;
}
