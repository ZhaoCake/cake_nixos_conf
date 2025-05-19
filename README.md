# NixOS-WSL 模块化配置

这是一个针对NixOS-WSL的模块化Flake配置，使用声明式配置管理系统，结合Home Manager进行用户环境管理。

## 配置结构

```
.
├── flake.nix          # 主配置入口，整合所有模块
├── home.nix           # Home Manager配置入口
├── home-modules/      # Home Manager模块目录
│   ├── git.nix        # Git配置
│   ├── packages.nix   # 用户软件包
│   └── shell.nix      # Shell配置（如starship）
└── modules/           # 系统模块目录
    ├── core/          # 核心WSL配置
    │   └── default.nix
    ├── shells/        # Shell相关配置
    │   └── fish.nix   # Fish Shell配置
    ├── system/        # 系统级配置
    │   └── default.nix
    └── users/         # 用户配置
        └── default.nix
```

## 设计理念

此配置遵循以下设计原则：

1. **模块化**：将不同功能分离到独立模块中，使配置更清晰、易于维护
2. **声明式**：通过Nix语言声明系统状态，而不是通过命令式脚本
3. **可复用**：模块可以轻松在不同配置间共享和重用
4. **版本控制**：所有配置可以通过Git进行版本控制
5. **可重现**：使用Flakes锁定依赖版本，确保配置可重现

## 模块说明

### 系统模块

- **core**：核心WSL配置，包括WSL特定设置、时区、本地化等
- **system**：系统级配置，包括系统软件包、服务、防火墙等
- **users**：用户配置，定义系统用户
- **shells**：Shell相关配置，目前包含Fish Shell

### Home Manager模块

- **packages.nix**：用户级软件包
- **git.nix**：Git配置
- **shell.nix**：Shell配置（如starship终端提示符）

## 使用方法

### 初始安装

1. 克隆此仓库：
   ```bash
   git clone https://your-repo-url cake_nixos_conf
   cd cake_nixos_conf
   ```

2. 应用配置：
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

### 更新配置

修改配置文件后，运行：

```bash
sudo nixos-rebuild switch --flake .#nixos
```

### 添加新模块

1. 在相应的目录中创建新的Nix文件
2. 在主配置（flake.nix）或相应的入口文件中导入新模块

## 扩展建议

- 添加更多特定用途的模块（如开发环境、图形界面等）
- 根据不同机器创建多个配置变体
- 添加自动化测试确保配置有效性

## 版本信息

- NixOS版本：24.11
- 创建日期：2025年5月
