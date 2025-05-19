{
  description = "NixOS-WSL 模块化Flake配置";

  # 输入源 - 定义配置所需的外部依赖
  inputs = {
    # Nixpkgs - Nix软件包集合
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    
    # NixOS-WSL - 提供WSL特定功能
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs"; # 确保使用相同的nixpkgs
    };
    
    # Home-Manager - 用户环境管理
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs"; # 确保使用相同的nixpkgs
    };
  };

  # 输出 - 定义系统配置
  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # 系统架构
      
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
        { system.stateVersion = "24.11"; }
      ];
    };
  };
}
