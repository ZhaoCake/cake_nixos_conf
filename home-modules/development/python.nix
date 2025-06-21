# Python 开发环境模块
{ config, pkgs, lib, ... }:

{
  options = {
    development.python.enable = lib.mkEnableOption "Python development environment";
  };

  config = lib.mkIf config.development.python.enable {
    home.packages = with pkgs; [
      # Python 解释器和包管理
      python3
      python3Packages.pip
      python3Packages.virtualenv
      python3Packages.pipenv
      
      # 开发工具
      python3Packages.black    # 代码格式化
      python3Packages.pylint   # 代码检查
      python3Packages.pytest   # 测试框架
    ];
  };
}
