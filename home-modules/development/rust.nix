# Rust 开发环境模块
{ config, pkgs, lib, ... }:

{
  options = {
    development.rust.enable = lib.mkEnableOption "Rust development environment";
  };

  config = lib.mkIf config.development.rust.enable {
    home.packages = with pkgs; [
      # Rust 工具链
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
    ];
  };
}
