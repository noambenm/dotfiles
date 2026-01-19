#!/bin/bash
set -e

# Define the target directory for completions (inside your Stow structure)
COMPLETION_DIR="$HOME/.zsh/completions"
echo "Installing tools and generating completions into: $COMPLETION_DIR"

# Ensure the directory exists
mkdir -p "$COMPLETION_DIR"

# 1. Fix ~/.kube permissions
if [ -d "$HOME/.kube" ]; then
    echo "Fixing ~/.kube permissions..."
    # On macOS, user group is usually 'staff' (id -g), which is fine.
    sudo chown -R $(id -u):$(id -g) ~/.kube
fi

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is not installed. Please install it first."
    exit 1
fi

# 2. Install Tools via Homebrew
echo "Installing/Updating tools via Homebrew..."

# Helper function to install if missing
install_if_missing() {
    if ! command -v $1 &> /dev/null; then
        echo "Installing $1..."
        brew install $2
    else
        echo "$1 is already installed."
    fi
}

install_if_missing kubectl kubectl
install_if_missing kubens kubectx  # 'kubectx' brew formula includes kubens
install_if_missing helm helm
install_if_missing kustomize kustomize
install_if_missing cilium cilium-cli
install_if_missing flux fluxcd/tap/flux

echo "----------------------------------------------------"
echo "Generating Completion Files..."

# 3. Generate Completions
# We overwrite the files in your dotfiles repo (via the symlink)

# Kubectl
kubectl completion zsh > "$COMPLETION_DIR/_kubectl"

# Helm
helm completion zsh > "$COMPLETION_DIR/_helm"

# Kustomize
kustomize completion zsh > "$COMPLETION_DIR/_kustomize"

# Cilium
cilium completion zsh > "$COMPLETION_DIR/_cilium"

# Flux
flux completion zsh > "$COMPLETION_DIR/_flux"

echo "----------------------------------------------------"
echo "Success! Completion files have been written to $COMPLETION_DIR"
echo "Don't forget to reload your shell: source ~/.zshrc"
