# C/C++ 开发环境模块
{ config, pkgs, lib, ... }:

let
  devPackages = import ../../lib/dev-packages.nix { inherit pkgs; };
in
{
  options = {
    development.c-cpp.enable = lib.mkEnableOption "C/C++ development environment";
  };

  config = lib.mkIf config.development.c-cpp.enable {
    home.packages = devPackages.cpp;
  };
}
