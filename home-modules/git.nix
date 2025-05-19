# Git配置模块
{ config, pkgs, ... }:

{
  # Git配置
  programs.git = {
    enable = true;
    
    # 用户信息
    userName = "Zhao Cake";
    userEmail = "zhaocake@foxmail.com";
    
    # 可以添加更多Git配置，例如：
    # extraConfig = {
    #   init.defaultBranch = "main";
    #   pull.rebase = false;
    #   core.editor = "vim";
    # };
  };
}
