{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    historyLimit = 10000;
    prefix = "C-a";
    sensibleOnTop = false;
    shell = "/run/current-system/sw/bin/fish";
    shortcut = "a";
    mouse = true;
    keyMode = "vi";
    escapeTime = 10;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = "set -g @catppuccin_flavour 'frappe'";
      }
    ];

    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set-option -g default-terminal "tmux-256color"

      # bind == bind-key
      bind-key -r f run-shell "tmux neww tmux-sessionizer.sh"
      bind-key c new-window -c "#{pane_current_path}"

      # setw -g mode-keys vi
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind P paste-buffer

      # vim-like pane switching
      bind -r ^ last-window
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R

      # window_activity is last time of activity in current window in unix time
      # formatting is done with strftime, see man strftime for more information
      # set -g status-right "maxrn #{t/f/%%H#:%%M %%Y-%%-m-%%d %%A:window_activity} "

      # So session name doesn't get cut off
      set -g status-left-length 20 # could be any number

      # Session quickswitches
      bind-key -r R run-shell "tmux-sessionizer.sh ~/uni/SGXDataCenterAttestationPrimitives"
      bind-key -r U run-shell "tmux-sessionizer.sh ~/uni/linux-sgx"
    '';
  };
}
