# RISC-V 操作系统开发环境模块
{ config, pkgs, lib, ... }:

let
  devPackages = import ../../lib/dev-packages.nix { inherit pkgs; };
in
{
  options = {
    development.riscv-os.enable = lib.mkEnableOption "RISC-V OS development environment";
  };

  config = lib.mkIf config.development.riscv-os.enable {
    home.packages = devPackages.riscv-os;

    # 设置环境变量
    home.sessionVariables = {
      # RISC-V 工具链前缀
      CROSS_COMPILE = "riscv64-unknown-elf-";
      RISCV32_CROSS_COMPILE = "riscv32-unknown-elf-";
    };
  };
}
