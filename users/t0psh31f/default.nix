{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "t0psh31f";
  home.homeDirectory = "/home/t0psh31f";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # The star of the show
  omarchy = {
    full_name = "t0psh31f";
    email_address = "";
    theme = "tokyo-night";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
