# Node.js/JavaScript 开发环境模块
{ config, pkgs, lib, ... }:

{
  options = {
    development.nodejs.enable = lib.mkEnableOption "Node.js/JavaScript development environment";
  };

  config = lib.mkIf config.development.nodejs.enable {
    home.packages = with pkgs; [
      # Node.js 运行时和包管理器
      nodejs
      npm
      yarn
      pnpm
      
      # 开发工具
      nodePackages.typescript
      nodePackages.eslint
      nodePackages.prettier
    ];
  };
}
