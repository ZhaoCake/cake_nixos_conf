# Python 开发环境模块
{ config, pkgs, lib, ... }:

let
  devPackages = import ../../lib/dev-packages.nix { inherit pkgs; };
in
{
  options = {
    development.python.enable = lib.mkEnableOption "Python development environment";
  };

  config = lib.mkIf config.development.python.enable {
    home.packages = devPackages.python;
  };
}
