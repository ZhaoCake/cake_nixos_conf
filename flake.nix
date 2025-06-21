{
  description = "NixOS-WSL 模块化Flake配置";

  # 输入源 - 定义配置所需的外部依赖
  inputs = {
    # Nixpkgs - Nix软件包集合
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # NixOS-WSL - 提供WSL特定功能
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs"; # 确保使用相同的nixpkgs
    };
    
    # Home-Manager - 用户环境管理
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # 确保使用相同的nixpkgs
    };
  };

  # 输出 - 定义系统配置和开发环境
  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # NixOS 系统配置
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      
      modules = [
        # WSL核心模块
        nixos-wsl.nixosModules.default
        
        # Home-Manager模块
        home-manager.nixosModules.home-manager
        {
          # Home-Manager配置
          home-manager = {
            useGlobalPkgs = true;     # 使用全局包集
            useUserPackages = true;   # 将用户包添加到系统路径
            users.nixos = import ./home.nix; # 导入用户配置
            backupFileExtension = "backup"; # 自动备份冲突文件
          };
        }
        
        # 导入自定义模块
        ./modules/core         # WSL核心配置
        ./modules/system       # 系统级配置
        ./modules/users        # 用户配置
        ./modules/shells/fish.nix  # Fish shell配置
        { shells.fish.enable = true; }
        # 系统版本锁定（防止意外升级破坏系统）
        { system.stateVersion = "25.05"; }
      ];
    };

    # 开发环境 - 使用 nix develop 进入
    devShells.${system} = {
      # C/C++ 开发环境
      cpp = pkgs.mkShell {
        name = "cpp-dev-environment";
        buildInputs = with pkgs; [
          gcc
          gdb
          cmake
          gnumake
          valgrind
          clang-tools
        ];
        shellHook = ''
          echo "🚀 C/C++ 开发环境已激活"
          echo "可用工具: gcc, g++, cmake, make, gdb, valgrind"
        '';
      };

      # Python 开发环境
      python = pkgs.mkShell {
        name = "python-dev-environment";
        buildInputs = with pkgs; [
          python3
          python3Packages.pip
          python3Packages.virtualenv
          python3Packages.black
          python3Packages.pylint
          python3Packages.pytest
        ];
        shellHook = ''
          echo "🐍 Python 开发环境已激活"
          echo "可用工具: python3, pip, virtualenv, black, pylint, pytest"
        '';
      };

      # Node.js 开发环境
      nodejs = pkgs.mkShell {
        name = "nodejs-dev-environment";
        buildInputs = with pkgs; [
          nodejs
          npm
          yarn
          pnpm
          nodePackages.typescript
          nodePackages.eslint
          nodePackages.prettier
        ];
        shellHook = ''
          echo "📦 Node.js 开发环境已激活"
          echo "可用工具: node, npm, yarn, pnpm, tsc, eslint, prettier"
        '';
      };

      # Rust 开发环境
      rust = pkgs.mkShell {
        name = "rust-dev-environment";
        buildInputs = with pkgs; [
          rustc
          cargo
          rustfmt
          clippy
          rust-analyzer
        ];
        shellHook = ''
          echo "🦀 Rust 开发环境已激活"
          echo "可用工具: rustc, cargo, rustfmt, clippy, rust-analyzer"
        '';
      };

      # 硬件开发环境
      hardware = pkgs.mkShell {
        name = "hardware-dev-environment";
        buildInputs = with pkgs; [
          verilator
          # 可以添加其他硬件开发工具
        ];
        shellHook = ''
          echo "⚡ 硬件开发环境已激活"
          echo "可用工具: verilator"
        '';
      };

      # 默认开发环境（包含所有工具）
      default = pkgs.mkShell {
        name = "full-dev-environment";
        buildInputs = with pkgs; [
          # 从各个开发环境中选择常用工具
          gcc gdb cmake
          python3 python3Packages.pip
          nodejs npm
          rustc cargo
          verilator
        ];
        shellHook = ''
          echo "🛠️  完整开发环境已激活"
          echo "包含: C/C++, Python, Node.js, Rust, 硬件开发工具"
          echo ""
          echo "使用专用环境:"
          echo "  nix develop .#cpp     - C/C++ 开发"
          echo "  nix develop .#python  - Python 开发"
          echo "  nix develop .#nodejs  - Node.js 开发"
          echo "  nix develop .#rust    - Rust 开发"
          echo "  nix develop .#hardware - 硬件开发"
        '';
      };
    };
  };
}
