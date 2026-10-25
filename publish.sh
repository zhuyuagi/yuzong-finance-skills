#!/usr/bin/env bash
# 一键发布到 GitHub + Gitee（开源社区版 · 双平台同步）
# 前置（Token 走环境变量，绝不写进仓库）：
#   export GITHUB_TOKEN=你的GitHubToken
#   export GITEE_TOKEN=你的Gitee令牌
# 用法：在 Git Bash 里进入本目录，执行  bash publish.sh
set -e

GH_OWNER="zhuyuagi";  GH_REPO="yuzong-finance-skills"
GE_OWNER="jakezhu888"; GE_REPO="yuzong-finance-skills"
BRANCH="main"

cd "$(dirname "$0")"

if [ ! -d .git ]; then
  git init -q
fi

git add -A
if git diff --cached --quiet; then
  echo "（没有新改动，跳过提交）"
else
  git commit -m "chore: 同步社区开源版 (CC BY-NC 4.0)"
fi

# 统一分支名为 main
CUR=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "$BRANCH")
if [ "$CUR" != "$BRANCH" ]; then
  git branch -m "$BRANCH" 2>/dev/null || true
fi

# 推一个平台：用 token 拼临时 remote，推完即删，避免 token 残留在 .git/config
push_one() {
  name="$1"; owner="$2"; repo="$3"; token="$4"
  if [ -z "$token" ]; then
    echo "[跳过] $name：未设置对应 Token 环境变量"
    return
  fi
  if [ "$name" = "github" ]; then URL="https://${token}@github.com/${owner}/${repo}.git"; fi
  if [ "$name" = "gitee" ];   then URL="https://${token}@gitee.com/${owner}/${repo}.git"; fi
  git remote remove "$name" 2>/dev/null || true
  git remote add "$name" "$URL"
  echo ""
  echo "== 推送到 $name =="
  if git push -u "$name" "$BRANCH"; then
    echo "[OK] $name 推送成功"
  else
    echo "[!!] $name 推送失败：确认已建好空仓库且 Token 有写权限"
  fi
  git remote remove "$name" 2>/dev/null || true
}

push_one github "$GH_OWNER" "$GH_REPO" "${GITHUB_TOKEN:-}"
push_one gitee   "$GE_OWNER" "$GE_REPO" "${GITEE_TOKEN:-}"

echo ""
echo "完成。仓库地址："
echo "  GitHub: https://github.com/zhuyuagi/yuzong-finance-skills"
echo "  Gitee : https://gitee.com/jakezhu888/yuzong-finance-skills"
