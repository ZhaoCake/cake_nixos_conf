# 系统模块 - 系统级软件包和服务配置
{ config, pkgs, lib, ... }:

{
  # 系统级软件包
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    tmux
    fish
    htop
    direnv
  ];

  # 环境变量设置
  environment.variables = {
    EDITOR = "vim";
    SHELL = "${pkgs.fish}/bin/fish";
  };

  # OpenSSH服务配置
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # 防火墙配置
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];  # SSH端口
  };

  # direnv的shell集成
  programs.direnv.enable = true;
}
