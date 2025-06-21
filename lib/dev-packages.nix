# 开发环境包集合 - 供 Home Manager 和 devShells 共享
{ pkgs }:

{
  # C/C++ 开发包集合
  cpp = with pkgs; [
    gcc
    gdb
    cmake
    gnumake
    valgrind
    clang-tools
    binutils
  ];

  # Python 开发包集合
  python = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.black
    python3Packages.pylint
    python3Packages.pytest
  ];

  # Node.js 开发包集合
  nodejs = with pkgs; [
    nodejs
    nodePackages.npm
    yarn
    pnpm
    nodePackages.typescript
    nodePackages.eslint
    nodePackages.prettier
  ];

  # Rust 开发包集合
  rust = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
  ];

  # 硬件开发包集合
  hardware = with pkgs; [
    verilator
    # 可以添加其他硬件工具
    # iverilog
    # gtkwave
  ];

  # RISC-V 操作系统开发包集合
  riscv-os = with pkgs; [
    # 基础 C/C++ 工具
    gcc
    gdb
    gnumake
    cmake
    binutils
    
    # RISC-V 交叉编译工具链
    pkgsCross.riscv64.buildPackages.gcc
    pkgsCross.riscv32.buildPackages.gcc
    
    # QEMU 仿真器
    qemu
    
    # 网络工具
    wget
    curl
    
    # 文件处理工具
    file
    xxd
  ];
}
