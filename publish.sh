#!/usr/bin/env bash
# 一键发布到 GitHub + Gitee（开源社区版 · 双平台同步）
# 前置：
#   ① GitHub 已建空仓库：zhuyuagi/yuzong-finance-skills（Public）
#   ② Gitee  已建空仓库：ZhuYu-Aim/yuzong-finance-skills（开源，许可选 CC BY-NC 4.0）
#   ③ 推送时密码填对应平台的 Personal Access Token（不是登录密码）
# 用法：在 Git Bash 里进入本目录，执行  bash publish.sh
set -e

GH_REMOTE="https://github.com/zhuyuagi/yuzong-finance-skills.git"
GE_REMOTE="https://gitee.com/ZhuYu-Aim/yuzong-finance-skills.git"
BRANCH="main"

cd "$(dirname "$0")"

if [ ! -d .git ]; then
  git init -q
fi

git add -A
if git diff --cached --quiet; then
  echo "（没有新改动，跳过提交）"
else
  git commit -m "init: 宇总·财会实战 社区开源版 v0.1 (CC BY-NC 4.0)"
fi

# 配置双远端：github + gitee
for pair in "github:$GH_REMOTE" "gitee:$GE_REMOTE"; do
  name="${pair%%:*}"; url="${pair#*:}"
  if git remote | grep -q "^$name$"; then
    git remote set-url "$name" "$url"
  else
    git remote add "$name" "$url"
  fi
done

# 统一分支名为 main
CUR=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "$BRANCH")
if [ "$CUR" != "$BRANCH" ]; then
  git branch -m "$BRANCH" 2>/dev/null || true
fi

push_one() {
  name="$1"
  echo ""
  echo "== 推送到 $name =="
  if git push -u "$name" "$BRANCH"; then
    echo "[OK] $name 推送成功"
  else
    echo "[!!] $name 推送失败：请确认已在网页建好对应空仓库，且 Token 有 repo 写权限"
  fi
}

push_one github
push_one gitee

echo ""
echo "完成。仓库地址："
echo "  GitHub: https://github.com/zhuyuagi/yuzong-finance-skills"
echo "  Gitee : https://gitee.com/ZhuYu-Aim/yuzong-finance-skills"
