# 核心模块 - 包含NixOS WSL的基础配置
{ config, pkgs, lib, ... }:

{
  # 启用 WSL 特性
  wsl = {
    enable = true;
    defaultUser = "nixos";
  };

  # 启用 Nix 实验性功能
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # nix-ld 支持（用于运行非NixOS的二进制文件）
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  # 时区设置
  time.timeZone = "Asia/Shanghai";
  
  # 网络时间同步（防止硬件时钟漂移）
  services.timesyncd.enable = true; 

  # 本地化配置
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8"];
  };
}
