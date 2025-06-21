# C/C++ 开发环境模块
{ config, pkgs, lib, ... }:

{
  options = {
    development.c-cpp.enable = lib.mkEnableOption "C/C++ development environment";
  };

  config = lib.mkIf config.development.c-cpp.enable {
    home.packages = with pkgs; [
      # 编译工具链
      gcc
      binutils
      gnumake
      cmake
      
      # 调试和分析工具
      gdb
      valgrind
      
      # 代码格式化
      clang-tools
    ];
  };
}
