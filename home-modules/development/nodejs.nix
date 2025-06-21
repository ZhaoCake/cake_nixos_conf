# Node.js/JavaScript 开发环境模块
{ config, pkgs, lib, ... }:

let
  devPackages = import ../../lib/dev-packages.nix { inherit pkgs; };
in
{
  options = {
    development.nodejs.enable = lib.mkEnableOption "Node.js/JavaScript development environment";
  };

  config = lib.mkIf config.development.nodejs.enable {
    home.packages = devPackages.nodejs;
  };
}
