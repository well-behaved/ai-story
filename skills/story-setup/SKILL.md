---
name: story-setup
description: 初始化 ai-story 写作环境，部署 hooks、agents、规则文件到项目目录
when_to_use: 用户说"初始化"、"部署"、首次使用时
---

# Story Setup - 初始化部署

## 职责

检测并初始化小说写作环境，确保所有必要的 hooks、agents、规则文件就位。

## 执行流程

### Step 1: 检测当前状态

检查 `.story-deployed` 文件是否存在：
- 存在 → 告知用户"环境已部署"，询问是否需要重新部署
- 不存在 → 继续部署

### Step 2: 部署 Agents

将以下 Agent 定义文件复制到 `.claude/agents/`：
- `planner.md` — 规划Agent
- `writer.md` — 写作Agent
- `reviewer.md` — 审查Agent
- `tracker.md` — 追踪Agent
- `polisher.md` — 润色Agent（六大门禁去AI味）

从 Skill 的 `agents/` 目录读取内容，写入到项目的 `.claude/agents/` 目录。

### Step 3: 部署 Hooks

将 hook 脚本部署到 `.claude/hooks/`：
- `session-start.sh/.ps1` — 会话启动时加载进度
- `pre-compact.sh/.ps1` — 上下文压缩前保存快照
- `post-compact.sh/.ps1` — 上下文压缩后提示恢复

在 `.claude/settings.local.json` 中注册（根据平台选择）：

Windows 环境：
```json
{
  "hooks": {
    "SessionStart": [
      { "type": "command", "command": "powershell -ExecutionPolicy Bypass -File .claude/hooks/session-start.ps1" }
    ],
    "PreCompact": [
      { "type": "command", "command": "powershell -ExecutionPolicy Bypass -File .claude/hooks/pre-compact.ps1" }
    ],
    "PostCompact": [
      { "type": "command", "command": "powershell -ExecutionPolicy Bypass -File .claude/hooks/post-compact.ps1" }
    ]
  }
}
```

Linux/Mac 环境：
```json
{
  "hooks": {
    "SessionStart": [
      { "type": "command", "command": ".claude/hooks/session-start.sh" }
    ],
    "PreCompact": [
      { "type": "command", "command": ".claude/hooks/pre-compact.sh" }
    ],
    "PostCompact": [
      { "type": "command", "command": ".claude/hooks/post-compact.sh" }
    ]
  }
}
```

### Step 4: 创建 CLAUDE.md

在项目根目录写入 `CLAUDE.md`：

```markdown
# 小说写作项目

本项目使用 ai-story Skill 进行 AI 辅助网文创作。

## 核心规则
- 串行逐章写作，不允许跳章或并行
- 写作时不修改 00-设定/ 下的文件
- 每章写完必须更新 03-追踪/ 下的状态文件
- 使用 P0-P5 优先级组装上下文，总量不超过 12000 字

## 项目状态
读取 `.story-state` 获取当前进度。

## 快速操作
- "日更" — 写下一章
- "去AI味" — 处理最新章节
- "全局审查" — 检查全书一致性
```

### Step 5: 创建标记文件

写入 `.story-deployed`：
```
deployed_at: {当前时间}
version: 1.0.0
```

### Step 6: 确认

输出部署结果：
```
✅ ai-story 环境已部署
  - Agents: planner, writer, reviewer, tracker
  - Hooks: session-start
  - CLAUDE.md: 已创建

下一步：说"帮我开一本小说"开始创作
```
