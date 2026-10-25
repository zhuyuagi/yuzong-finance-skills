# 如何发布 / 同步到 GitHub + Gitee（双平台）

## 当前状态（2026-10-25）
- ✅ **GitHub 已上线**：https://github.com/zhuyuagi/yuzong-finance-skills （Public，默认分支 `main`，内容已推送）
- ⏳ **Gitee 待建**：当前 Gitee 账号（用户名 **jakezhu888**）安全评级较低，建仓库 / 生成令牌前必须先在「设置 → 安全设置」开启**两步验证（2FA）**，或到「设置 → 第三方账号绑定」绑定微信 / QQ / GitHub 等。开启后由助手自动建仓 + 推送。

## 双平台定位
- **Gitee**：国内主阵地（零门槛访问、引力节 / GVP 曝光、对接国内财税从业者）。
- **GitHub**：国际镜像 + 技术背书。

## 方式一：本机一键双推（推荐，需在个人电脑上执行）
前置：
1. 两个平台都已建好**空**仓库（不要勾 README / 初始化文件）：
   - GitHub：`zhuyuagi/yuzong-finance-skills`（Public）
   - Gitee：`jakezhu888/yuzong-finance-skills`（开源 / 公开，许可证选 **CC BY-NC 4.0**）
2. 准备两个 Personal Access Token（密码处填 Token，**不是登录密码**）：
   - GitHub：Settings → Developer settings → PAT → 勾 `repo`
   - Gitee：设置 → 私人令牌 → 勾 `projects`

在**项目目录**执行（Token 走环境变量，不进仓库）：
```bash
export GITHUB_TOKEN=你的GitHubToken
export GITEE_TOKEN=你的Gitee令牌
bash publish.sh
```
脚本会提交本地改动，并分别推到 `github` / `gitee` 两个远端（推送后自动清理 token，不残留在本地配置）。

## 方式二：仅补推 Gitee
GitHub 已上线，等 Gitee 开启 2FA 后，执行方式一即可（GitHub 已存在会被更新，Gitee 会被创建 + 推送）。

## 方式三：无 Git 网页拖拽
两个平台进仓库后「上传文件」，把本目录全部（含 `skills/` 子目录、`LICENSE`、`README.md`、`publish.sh`）拖进去。

---

## 发布后建议
- Gitee 为主阵地：参加开源活动（如引力节）、申请 GVP 曝光，国内用户访问零门槛。
- GitHub 做镜像：Settings → About 填简介，README 已挂双平台地址。
- 后续补充更多岗位社区版时，直接往 `skills/` 加目录，再跑一次 `publish.sh` 双平台同步。

> 注意：开源仓库只放「讲解 + 通用框架 + 脱敏示例」，核心校准阈值与全套出活模板留在 WorkBuddy 付费版（永不公开）。详见 README.md 的「开源 / 闭源边界」。
