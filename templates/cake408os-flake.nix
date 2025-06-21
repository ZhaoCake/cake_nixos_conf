# Cake408OS 项目专用 flake.nix 模板
# 将此文件复制到你的 Cake408OS 项目根目录
{
  description = "Cake408OS - RISC-V 操作系统开发环境";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # 可选：引用你的全局配置
    # my-config.url = "path:/home/nixos/cake_nixos_conf";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      name = "cake408os-dev";
      
      buildInputs = with pkgs; [
        # RISC-V 交叉编译工具链
        pkgsCross.riscv64.buildPackages.gcc
        pkgsCross.riscv32.buildPackages.gcc
        
        # QEMU 仿真器
        qemu
        
        # 调试工具
        gdb
        
        # 构建工具
        gnumake
        
        # 网络和文件工具
        wget
        curl
        file
        xxd
        
        # 可选：代码编辑和格式化工具
        neovim
        clang-tools
      ];

      shellHook = ''
        echo "🚀 Cake408OS 开发环境已激活"
        echo ""
        echo "🔧 工具链配置:"
        echo "  CROSS_COMPILE: riscv64-unknown-elf-"
        echo "  RISCV32 工具: riscv32-unknown-elf-gcc"
        echo ""
        echo "🎯 常用命令:"
        echo "  make all     - 构建内核"
        echo "  make run     - 运行在 QEMU 中"
        echo "  make debug   - 启动调试模式"
        echo "  make clean   - 清理构建文件"
        echo "  make disasm  - 生成反汇编"
        echo ""
        
        # 设置交叉编译环境变量
        export CROSS_COMPILE="riscv64-unknown-elf-"
        export RISCV32_CROSS_COMPILE="riscv32-unknown-elf-"
        
        # 添加工具链到 PATH
        export PATH="${pkgs.pkgsCross.riscv64.buildPackages.gcc}/bin:$PATH"
        export PATH="${pkgs.pkgsCross.riscv32.buildPackages.gcc}/bin:$PATH"
        
        # 创建便捷别名
        alias riscv-gcc="riscv64-unknown-elf-gcc"
        alias riscv32-gcc="riscv32-unknown-elf-gcc"
        alias riscv-gdb="riscv64-unknown-elf-gdb"
        alias qemu-riscv32="qemu-system-riscv32"
        
        # 验证工具链
        echo "✅ 验证工具链:"
        if command -v riscv64-unknown-elf-gcc &> /dev/null; then
          echo "  ✓ RISC-V GCC: $(riscv64-unknown-elf-gcc --version | head -n1)"
        else
          echo "  ✗ RISC-V GCC 未找到"
        fi
        
        if command -v qemu-system-riscv32 &> /dev/null; then
          echo "  ✓ QEMU RISC-V: $(qemu-system-riscv32 --version | head -n1)"
        else
          echo "  ✗ QEMU RISC-V 未找到"
        fi
        
        echo ""
        echo "💡 提示: 使用 'exit' 退出开发环境"
      '';
    };
  };
}
