# 用户模块 - 用户级别的配置
{ config, pkgs, lib, ... }:

{
  # 用户定义会被导入到系统中
  # 默认用户配置由 wsl.defaultUser 指定
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # 添加到wheel组使用户可以使用sudo
    # 如果需要设置密码，可以使用这一行（不推荐直接明文设置）
    # initialPassword = "changeme";
  };
}
