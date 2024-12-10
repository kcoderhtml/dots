{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # git config
  programs.git = {
    enable = true;
    userName = "Kieran Klukas";
    userEmail = "92754843+kcoderhtml@users.noreply.github.com";
    aliases = {
      c = "commit";
      p = "push";
      ch = "checkout";
    };
    extraConfig = {
      branch.sort = "-committerdate";
      pager.branch = false;
      column.ui = "auto";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowedSigners";
      user.signingKey = "~/.ssh/id_rsa.pub";
      pull.rebase = true;
    };
  };
}
