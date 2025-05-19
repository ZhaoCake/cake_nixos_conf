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
    # 用户级软件包
    ./home-modules/packages.nix
    # Git配置
    ./home-modules/git.nix
    # Shell相关配置（如starship）  
    ./home-modules/shell.nix
  ];

  # Home Manager版本锁定
  # 这个值决定了你的配置与哪个Home Manager版本兼容
  # 有助于避免新版本引入向后不兼容的更改时出现问题
  home.stateVersion = "24.11";
  
  # 让Home Manager安装并管理自身
  programs.home-manager.enable = true;
}
