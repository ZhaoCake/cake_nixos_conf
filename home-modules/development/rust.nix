# Rust 开发环境模块
{ config, pkgs, lib, ... }:

let
  devPackages = import ../../lib/dev-packages.nix { inherit pkgs; };
in
{
  options = {
    development.rust.enable = lib.mkEnableOption "Rust development environment";
  };

  config = lib.mkIf config.development.rust.enable {
    home.packages = devPackages.rust;
  };
}
