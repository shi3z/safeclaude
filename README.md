# SafeClaude

Docker上でClaude Codeを安全に実行するツール。ホストマシンへのアクセスを最小限に制限し、指定したワーキングディレクトリのみ書き込み可能。

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

# 他のディレクトリを読み取り専用で追加
safeclaude ~/projects/myapp -r ~/projects/shared-lib -r ~/data
```

## セキュリティモデル

| 対象 | コンテナ内パス | 権限 |
|---|---|---|
| ワーキングディレクトリ | `/workspace` | 読み書き可 |
| `-r` で指定したディレクトリ | `/readonly/<name>` | 読み取り専用 |
| その他のホストファイル | マウントしない | アクセス不可 |

- ホスト全体をマウントしないため、情報漏洩リスクを最小化
- ネットワークは有効（pip install等に必要）だが、送れる情報を制限
- Claude Codeはコンテナ内で `--dangerously-skip-permissions` で動作

## オプション

```
-b, --build     Dockerイメージを強制再ビルド
-r, --ro-dir    読み取り専用ディレクトリを追加 (複数指定可)
-h, --help      ヘルプ表示
```

## License

MIT
