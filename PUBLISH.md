# 如何把本仓库发布到 GitHub + Gitee（双平台）

由于当前 WorkBuddy 的 GitHub 连接器只有**只读**授权，无法自动建仓 / 推送，请按下面任一种方式手动发布（内容都已准备好，只需建空仓库 + 跑一条命令）。

## 第一步：在两个平台各建一个空仓库

**GitHub**（github.com → 右上角 "+" → New repository）
- Repository name：`yuzong-finance-skills`
- 选 **Public**，**不要**勾 "Add a README file"

**Gitee**（gitee.com → 右上角 "+" → 新建仓库）
- 仓库名称：`yuzong-finance-skills`
- 选 **开源（公开）**，开源许可证选 **CC BY-NC 4.0**
- **不要**勾 "使用 Readme 文件初始化"

## 第二步：一键双推（推荐）

在本目录打开 **Git Bash**，执行：

```bash
bash publish.sh
```

脚本会自动 commit 并分别推送到 GitHub 和 Gitee 两个远端。
提示：推送时若要求输入密码，**填对应平台的 Personal Access Token**（不是登录密码）：
- GitHub Token：Settings → Developer settings → Personal access tokens → 勾选 `repo` 权限
- Gitee 令牌：设置 → 私人令牌 → 勾选 `projects` 权限

> 若你的 Gitee 用户名不是 `ZhuYu-Aim`，改 `publish.sh` 里 `GE_REMOTE` 一行即可。

## 备选方式

**GitHub CLI（若已装 `gh` 且登录）**：
```bash
gh repo create yuzong-finance-skills --public --source=. --remote=origin --push
```

**网页拖拽（最省事，无需 Git）**：两个平台都支持进仓库后 "上传文件"，把本目录全部文件（含 `skills/` 子目录、`LICENSE`、`README.md`）拖进去即可。

---

## 发布后建议

- Gitee 为主阵地：参加 Gitee 开源活动（如引力节）、申请 GVP 曝光，国内用户访问零门槛。
- GitHub 做镜像：Settings → About 填简介，README 已挂双平台地址。
- 后续补充更多岗位社区版时，直接往 `skills/` 加目录，再跑一次 `publish.sh` 双平台同步。
