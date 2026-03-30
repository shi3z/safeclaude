#!/bin/bash
set -euo pipefail

INSTALL_DIR="$HOME/.safeclaude"
REPO_URL="https://github.com/shi3z/safeclaude.git"

echo "=== SafeClaude Installer ==="

# Check dependencies
if ! command -v docker &>/dev/null; then
    echo "Error: docker が見つかりません。先にDockerをインストールしてください。" >&2
    exit 1
fi

if ! command -v git &>/dev/null; then
    echo "Error: git が見つかりません。" >&2
    exit 1
fi

# Clone or update
if [[ -d "$INSTALL_DIR" ]]; then
    echo "既存のインストールを更新中..."
    git -C "$INSTALL_DIR" pull --ff-only
else
    echo "ダウンロード中..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Build Docker image
echo "Dockerイメージをビルド中..."
docker build -t safeclaude "$INSTALL_DIR"

# Install command to PATH
LINK_PATH="/usr/local/bin/safeclaude"
if [[ -w /usr/local/bin ]]; then
    ln -sf "$INSTALL_DIR/safeclaude.sh" "$LINK_PATH"
else
    echo "シンボリックリンクの作成に sudo が必要です..."
    sudo ln -sf "$INSTALL_DIR/safeclaude.sh" "$LINK_PATH"
fi

echo ""
echo "インストール完了!"
echo "使い方: safeclaude [ワーキングディレクトリ]"
echo ""
echo "例:"
echo "  safeclaude                    # カレントディレクトリで起動"
echo "  safeclaude ~/projects/myapp   # 指定ディレクトリで起動"
