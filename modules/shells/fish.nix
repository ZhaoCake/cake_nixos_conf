# 功能完整的Fish模块示例
{ config, pkgs, lib, ... }:

{
  options = {
    shells.fish.enable = lib.mkEnableOption "Fish shell configuration";
  };

  config = lib.mkIf config.shells.fish.enable {
    environment.systemPackages = with pkgs; [ fish ];
    environment.shells = [ pkgs.fish ];
    programs.fish.enable = true;
    
    users.users.${config.wsl.defaultUser} = {
      shell = pkgs.fish;
    };
  };
}
