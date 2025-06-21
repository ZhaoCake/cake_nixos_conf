# 开发环境使用指南

## 概述

我们的配置现在支持两种开发环境管理方式：

1. **Home Manager 模块**: 永久安装在用户环境中
2. **Flake devShells**: 临时的、项目专用的开发环境

## Home Manager 开发模块

在 `home.nix` 中启用/禁用开发环境：

```nix
development = {
  c-cpp.enable = true;      # C/C++ 开发环境
  python.enable = true;     # Python 开发环境  
  nodejs.enable = true;     # Node.js 开发环境
  rust.enable = true;       # Rust 开发环境
  hardware.enable = true;   # 硬件开发环境（Verilog等）
};
```

启用后需要运行：
```bash
sudo nixos-rebuild switch --flake .
```

## Flake 开发环境 (推荐)

使用 `nix develop` 进入临时开发环境：

### 可用的开发环境

```bash
# 进入 C/C++ 开发环境
nix develop .#cpp

# 进入 Python 开发环境
nix develop .#python

# 进入 Node.js 开发环境
nix develop .#nodejs

# 进入 Rust 开发环境
nix develop .#rust

# 进入硬件开发环境
nix develop .#hardware

# 进入默认环境（包含所有工具）
nix develop
```

### 项目专用环境

在项目目录中创建 `flake.nix`：

```nix
{
  description = "我的项目开发环境";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # 可以引用我们的配置
    my-config.url = "path:/home/nixos/cake_nixos_conf";
  };
  
  outputs = { self, nixpkgs, my-config, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        # 项目特定的依赖
        nodejs
        python3
      ];
      shellHook = ''
        echo "项目开发环境已激活"
      '';
    };
  };
}
```

## 优势

### Home Manager 模块
- ✅ 工具永久可用
- ✅ 系统启动时自动加载
- ❌ 占用系统空间
- ❌ 不同项目可能有版本冲突

### Flake devShells  
- ✅ 项目隔离，无版本冲突
- ✅ 按需加载，节省空间
- ✅ 可重现的开发环境
- ✅ 支持项目特定配置
- ❌ 需要手动进入环境

## 建议使用方式

1. **日常工具**: 在 Home Manager 中启用常用的开发环境
2. **项目开发**: 使用 `nix develop` 进入项目特定环境
3. **临时尝试**: 使用 devShells 测试新工具而不污染系统

## 添加新的开发环境

1. 在 `home-modules/development/` 中创建新模块
2. 在 `home-modules/development.nix` 中导入
3. 在 `flake.nix` 的 `devShells` 中添加对应环境
4. 更新此文档
