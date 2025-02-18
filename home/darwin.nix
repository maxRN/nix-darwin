{ config, pkgs, ... }:
let
  homeManagerHome = "/Users/maxrn/.config/home-manager";
  link = config.lib.file.mkOutOfStoreSymlink;
  linkHome = x: link "${homeManagerHome}" + "/${x}";
in
{
  home.shellAliases = {
    tailscale = "/Applications/Tailscale.app/Contents/MacOS/Tailscale";
  };

  home.file = {
    ".config/goku/karabiner.edn".source = linkHome "dotfiles/goku/karabiner.edn";
  };

  home.packages = with pkgs; [ gnupatch ];
}
