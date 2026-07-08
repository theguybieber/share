#!/bin/bash
# install.sh - Cross-platform Gemma 4 Setup (April 2026)

# 1. Detect OS and set Engine/Model
OS="$(uname)"
if [[ "$OS" == "Darwin" ]]; then
    ENGINE="vllm-mlx"
    MODEL="mlx-community/gemma-4-31b-it-4bit"
else
    ENGINE="turboquant-vllm"
    MODEL="google/gemma-4-31b-it"
fi

# 2. Ensure pipx & hf are ready
command -v pipx >/dev/null 2>&1 || { echo "Installing pipx..."; brew install pipx || sudo apt update && sudo apt install -y pipx; pipx ensurepath; }
pipx install huggingface_hub # Provides the 'hf' command

# 3. Install platform-specific engine
pipx install "$ENGINE"

# 4. Optimized Model Download (The new 'hf' way)
hf download "$MODEL"

# 5. Set the vllm alias
RC_FILE="$HOME/.zshrc"; [[ "$SHELL" != *"zsh"* ]] && RC_FILE="$HOME/.bashrc"
echo "alias vllm='$ENGINE'" >> "$RC_FILE"

echo "✅ Setup complete. Run: source $RC_FILE"
