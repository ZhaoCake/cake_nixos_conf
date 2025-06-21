# 硬件开发环境模块（Verilog/SystemVerilog）
{ config, pkgs, lib, ... }:

let
  devPackages = import ../../lib/dev-packages.nix { inherit pkgs; };
in
{
  options = {
    development.hardware.enable = lib.mkEnableOption "Hardware development environment (Verilog/SystemVerilog)";
  };

  config = lib.mkIf config.development.hardware.enable {
    home.packages = devPackages.hardware;
  };
}
