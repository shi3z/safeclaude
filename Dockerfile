FROM node:22-slim

# Install basic tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    vim \
    ripgrep \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Create non-root user
RUN useradd -m -s /bin/bash claude

# Create mount points
RUN mkdir -p /host /workspace && chown claude:claude /workspace

USER claude
WORKDIR /workspace

ENTRYPOINT ["claude", "--dangerously-skip-permissions"]
