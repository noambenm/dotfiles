# --- Path & Zsh Configuration ---

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# --- Completions Setup (Must be before sourcing OMZ) ---

# 1. Custom Completions (from Stow/Install script)
fpath=($HOME/.zsh/completions $fpath)

# 2. Docker Completions
if [ -d "$HOME/.docker/completions" ]; then
  fpath=($HOME/.docker/completions $fpath)
fi

# --- Plugins ---
# Added: kubectl (provides 'k' alias), helm, kubectx (provides 'kns'/'kctx')
plugins=(
  git 
  tmux
  kubectl
  helm
  kubectx
)

ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTONAME_SESSION=true

# --- Source Oh My Zsh ---
source $ZSH/oh-my-zsh.sh

# --- User Configuration ---

# Vi mode
set -o vi

# Editor
alias vim=nvim
# export EDITOR='nvim'

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
export GOOGLE_CLOUD_PROJECT=noambesandbox

# Terraform (Requires bashcompinit)
autoload -U +X bashcompinit && bashcompinit
if [ -f "/opt/homebrew/bin/terraform" ]; then
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi

# Envman
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# --- Custom Aliases ---

# Kubernetes
# 'k' is already aliased by the kubectl plugin, but 'cilium' needs one:
alias cilium='cilium --namespace cilium'

# Add any other aliases below
