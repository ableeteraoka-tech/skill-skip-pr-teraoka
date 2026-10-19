#!/bin/bash
# 毎朝の自動バックアップ：Claudeメモリ内の influencers/ をコピーしてGitHubへpush
set -e
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
REPO="$HOME/skill-skip-pr-teraoka"
SRC="$HOME/.claude/projects/-/memory/influencers/"

echo "=== $(date '+%Y-%m-%d %H:%M:%S') 開始 ==="
cd "$REPO"
rsync -a --exclude='.DS_Store' "$SRC" ./influencers/
git add -A
if git diff --cached --quiet; then
  echo "変更なし。スキップしました"
  exit 0
fi
git commit -m "作業データ更新 $(date '+%Y-%m-%d')"
git push
echo "pushしました"
