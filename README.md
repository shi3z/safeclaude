# SafeClaude

Docker上でClaude Codeを安全に実行するツール。ホストマシンのファイルは読み取り専用、指定したワーキングディレクトリのみ書き込み可能。

## インストール

```bash
curl -fsSL https://raw.githubusercontent.com/shi3z/safeclaude/main/install.sh | bash
```

## 必要なもの

- Docker
- `ANTHROPIC_API_KEY` 環境変数

## 使い方

```bash
# カレントディレクトリで起動
safeclaude

# 特定のプロジェクトで起動
safeclaude ~/projects/myapp
```

## セキュリティモデル

| マウント | コンテナ内パス | 権限 |
|---|---|---|
| ホスト `/` | `/host` | 読み取り専用 |
| ワーキングディレクトリ | `/workspace` | 読み書き可 |

Claude Codeはコンテナ内で `--dangerously-skip-permissions` で動作しますが、Dockerのマウント制約により、ホストへの書き込みは指定ディレクトリに限定されます。

## オプション

```
-b, --build     Dockerイメージを強制再ビルド
-r, --ro-dir    追加の読み取り専用マウント (複数指定可)
-h, --help      ヘルプ表示
```

## License

MIT
