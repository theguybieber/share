FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs

# Install development tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    vim \
    jq \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code and claude-flow globally
RUN npm install -g @anthropic-ai/claude-code claude-flow

# Configure dsp alias system-wide
RUN echo 'alias dsp="claude --dangerously-skip-permissions"' >> /etc/bash.bashrc && \
    mkdir -p /etc/zsh && \
    echo 'alias dsp="claude --dangerously-skip-permissions"' >> /etc/zsh/zshrc 2>/dev/null || true

# Set service connectivity environment defaults
ENV LITELLM_BASE_URL=http://litellm:4000
ENV LITELLM_ENDPOINT=http://litellm:4000
ENV ANTHROPIC_BASE_URL=http://litellm:4000
ENV OLLAMA_HOST=http://ollama:11434

WORKDIR /workspace
