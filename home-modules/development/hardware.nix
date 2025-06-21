# 硬件开发环境模块（Verilog/SystemVerilog）
{ config, pkgs, lib, ... }:

{
  options = {
    development.hardware.enable = lib.mkEnableOption "Hardware development environment (Verilog/SystemVerilog)";
  };

  config = lib.mkIf config.development.hardware.enable {
    home.packages = with pkgs; [
      # Verilog/SystemVerilog 工具
      verilator
      # 如果需要其他硬件工具可以在这里添加
      # iverilog
      # gtkwave
    ];
  };
}
