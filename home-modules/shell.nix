# Shell配置模块 - 包含shell相关的设置如starship
{ config, pkgs, ... }:

{
  # Starship终端提示符配置
  programs.starship = {
    enable = true;
    
    # 自定义配置
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      
      # 可以添加更多个性化配置
      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[✗](bold red)";
      # };
    };
  };
  
  # 可以添加其他shell相关配置
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/cake_nixos_conf/#nixos  --option substituters 'https://mirror.sjtu.edu.cn/nix-channels/store'";
    };
    # 启用Starship提示符整合
    interactiveShellInit = ''
      # 初始化Starship
      starship init fish | source
      
      # 显示一条消息确认fish shell正在运行
      echo "Fish shell已启动"
    '';
  };
}
