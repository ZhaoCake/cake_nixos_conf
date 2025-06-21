# 开发环境聚合模块
# 统一管理各种编程语言和开发工具
{ config, pkgs, lib, ... }:

{
  imports = [
    ./development/c-cpp.nix
    ./development/python.nix
    ./development/nodejs.nix
    ./development/rust.nix
    ./development/hardware.nix
  ];

  # 可以在这里添加一些全局开发相关的配置
  # 比如默认启用某些开发环境
  config = {
    # 示例：如果你经常使用这些环境，可以默认启用
    # development.c-cpp.enable = lib.mkDefault true;
    # development.python.enable = lib.mkDefault true;
  };
}
