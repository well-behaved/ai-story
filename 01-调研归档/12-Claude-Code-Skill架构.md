# Claude Code Skill 架构

SKILL.md格式规范、目录结构、子Agent、Hooks、Plugin打包等完整技术参考。

---

## SKILL.md 完整格式规范

### 基本结构

```markdown
---
description: 技能的简短描述（用于触发匹配）
globs: ["**/*.md", "src/**/*.ts"]  # 可选：匹配的文件模式
alwaysApply: false  # 可选：是否始终加载
---

# 技能名称

## 概述
技能的详细说明...

## 使用方法
如何使用这个技能...

## 规则和约束
技能执行时的规则...
```

### Frontmatter字段说明

| 字段 | 类型 | 必须 | 说明 |
|------|------|------|------|
| description | string | 是 | 简短描述，用于技能匹配和发现 |
| globs | string[] | 否 | 文件模式匹配，当编辑匹配文件时激活 |
| alwaysApply | boolean | 否 | 为true时始终加载到上下文 |

### 字符串替换变量

| 变量 | 说明 | 示例 |
|------|------|------|
| $ARGUMENTS | 用户传入的参数(全部) | "/skill arg1 arg2" → "arg1 arg2" |
| $0 | 第0个参数(技能名) | "skill-name" |
| $1 | 第1个参数 | "arg1" |
| $2 | 第2个参数 | "arg2" |
| ${CLAUDE_SESSION_ID} | 当前会话ID | "session_abc123" |
| ${CWD} | 当前工作目录 | "/Users/me/project" |

---

## 推荐目录结构

### 基础结构

```
.claude/
├── settings.json          # 项目设置（权限/hooks/MCP）
├── settings.local.json    # 本地设置（不提交git）
├── skills/
│   ├── novel-write/
│   │   └── SKILL.md      # 写作技能
│   ├── novel-review/
│   │   └── SKILL.md      # 审查技能
│   ├── novel-plan/
│   │   └── SKILL.md      # 规划技能
│   └── novel-export/
│       └── SKILL.md      # 导出技能
├── agents/
│   ├── writer.md          # 写手Agent定义
│   ├── reviewer.md        # 审查Agent定义
│   ├── editor.md          # 编辑Agent定义
│   └── worldbuilder.md    # 世界构建Agent定义
└── commands/
    ├── outline.md         # /outline命令
    ├── write.md           # /write命令
    └── export.md          # /export命令
```

### 含agents/子目录的完整结构

```
.claude/
├── settings.json
├── skills/
│   ├── 00-project-control/
│   │   └── SKILL.md       # 项目总控制
│   ├── 01-worldbuilding/
│   │   └── SKILL.md       # 世界观构建
│   ├── 02-character/
│   │   └── SKILL.md       # 角色设计
│   ├── 03-outline/
│   │   └── SKILL.md       # 大纲规划
│   ├── 04-style/
│   │   └── SKILL.md       # 风格定义
│   ├── 05-writing/
│   │   └── SKILL.md       # 章节写作
│   ├── 06-review/
│   │   └── SKILL.md       # 审查修订
│   ├── 07-consistency/
│   │   └── SKILL.md       # 一致性检查
│   ├── 08-deai/
│   │   └── SKILL.md       # 去AI味
│   └── 09-export/
│       └── SKILL.md       # 导出发布
├── agents/
│   ├── brainstormer.md
│   ├── writer.md
│   ├── critic.md
│   └── chronicler.md
└── hooks/
    └── (通过settings.json配置)
```

---

## 动态上下文注入

### !`command` 语法

在SKILL.md中可以使用动态命令注入实时信息：

```markdown
# 写作技能

当前项目状态:
!`cat story-bible.yaml | head -50`

最近修改的章节:
!`ls -lt chapters/ | head -5`

字数统计:
!`wc -c chapters/*.md | tail -1`
```

**工作原理**:
- Claude Code在加载SKILL.md时执行这些命令
- 命令输出被内联替换到技能文本中
- 每次调用技能时重新执行，确保信息最新

**常用动态注入**:
```markdown
!`cat .novel/bible.yaml`           # 注入Story Bible
!`cat .novel/progress.json`         # 注入写作进度
!`cat chapters/latest.md | tail -20` # 注入最近写的内容
!`git log --oneline -5`            # 注入最近修改记录
```

---

## 子Agent执行 (context: fork)

### Agent定义格式

```markdown
<!-- .claude/agents/writer.md -->
---
context: fork
model: claude-sonnet-4-20250514
maxTokens: 16000
---

# Writer Agent

你是一位专业的网文写手。你的任务是根据大纲和上下文生成高质量的正文。

## 规则
1. 严格遵循提供的大纲
2. 保持与前文的一致性
3. 每章3000-4000字
4. 使用提供的角色语音表
5. 章尾必须有钩子

## 输入
- 章节大纲
- 上下文信息(Story Bible + 前文摘要)
- 风格规范

## 输出
- 完整章节正文
- 章节事实提取(JSON)
```

### 调用方式

在主技能中调用子Agent:
```markdown
# 写作流程

1. 使用 Task 工具调用 writer agent:
   - 传入: 章节大纲 + 上下文
   - 获取: 章节正文

2. 使用 Task 工具调用 reviewer agent:
   - 传入: 章节正文 + Story Bible
   - 获取: 审查报告

3. 如果审查不通过:
   - 使用 Task 工具调用 writer agent 重写
```

### context: fork 含义

- **fork**: 子Agent在独立上下文中运行
- 不共享父Agent的对话历史
- 只接收明确传入的信息
- 输出返回给父Agent
- 适合需要隔离的专业任务

---

## 支持文件引用方式

### 在SKILL.md中引用文件

```markdown
# 写作技能

请参考以下文件:
- 角色设定: @characters/protagonist.yaml
- 世界观: @world/rules.yaml
- 风格指南: @style/guide.md

当前章节大纲:
!`cat outlines/chapter-$(cat .novel/progress.json | jq -r '.current_chapter').md`
```

### 引用模式

| 模式 | 语法 | 说明 |
|------|------|------|
| 静态引用 | `@filepath` | 加载时读取文件内容 |
| 动态命令 | `!``command`` ` | 每次调用时执行命令 |
| 条件引用 | 在规则中描述 | Claude自行决定是否读取 |

---

## Skill内容生命周期

### Compaction后保留规则

当Claude Code进行上下文压缩(compaction)时:
- **alwaysApply: true** 的Skill内容在压缩后仍被保留
- **alwaysApply: false** 的Skill内容可能在压缩后丢失
- 动态注入(`!`command``)每次重新执行
- Agent定义(context: fork)不受影响（独立上下文）

### 建议

```
核心规则/约束: 放在 alwaysApply: true 的Skill中
详细参考: 放在按需加载的Skill中
动态数据: 使用 !`command` 确保最新
大量静态数据: 让Claude按需Read文件
```

---

## 多步骤工作流模式

### 参考: doc-coauthoring 模式

```markdown
---
description: 逐章写作工作流
---

# 写作工作流

## 步骤

### Step 1: 准备上下文
1. 读取 .novel/progress.json 确定当前章节
2. 读取当前章节大纲
3. 读取 Story Bible 核心设定
4. 检索前3章摘要

### Step 2: 生成初稿
1. 调用 writer agent (context: fork)
2. 传入: 大纲 + 上下文 + 风格规范
3. 获取: 章节草稿

### Step 3: 审查
1. 调用 reviewer agent (context: fork)  
2. 传入: 草稿 + Bible + 前文
3. 获取: 审查报告(pass/fail + 具体问题)

### Step 4: 修订(如需)
1. 如果审查fail:
   - 调用 writer agent 重写问题段落
   - 回到Step 3重新审查
   - 最多3轮

### Step 5: 后处理
1. 从章节中提取新事实
2. 更新 Story Bible
3. 更新摘要
4. 更新 progress.json
5. 保存章节到 chapters/ 目录

### Step 6: 报告
1. 输出: 字数统计/质量评分/更新摘要
```

---

## 子Agent架构 (.claude/agents/ 格式)

### Writer Agent

```markdown
<!-- .claude/agents/writer.md -->
---
context: fork
---

# 网文写手

你是一位经验丰富的网文作者。

## 核心能力
- 根据大纲展开精彩正文
- 保持人物语言个性
- 控制节奏和爽点密度
- 章尾制造悬念

## 输出格式
直接输出章节正文，不要包含额外说明。
章节末尾另起一行输出:
```json
{"word_count": N, "characters_appeared": [...], "new_facts": [...]}
```
```

### Reviewer Agent

```markdown
<!-- .claude/agents/reviewer.md -->
---
context: fork
---

# 质量审查员

你是一位严格的小说编辑。

## 审查维度
1. 一致性: 与Story Bible是否矛盾
2. 角色: 行为是否符合设定
3. 逻辑: 因果是否合理
4. 风格: 是否符合风格规范
5. 节奏: 是否有足够爽点
6. AI味: 是否有明显AI痕迹

## 输出格式
```json
{
  "verdict": "pass|fail",
  "score": 1-10,
  "issues": [
    {"type": "consistency|character|logic|style|pacing|ai_taste", 
     "severity": "critical|major|minor",
     "description": "...",
     "location": "段落位置",
     "suggestion": "修改建议"}
  ]
}
```
```

---

## Hooks自动化

### 通过settings.json配置

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "python scripts/update_stats.py \"$FILE_PATH\""
      }
    ],
    "Stop": [
      {
        "command": "python scripts/post_session_summary.py"
      }
    ],
    "SessionStart": [
      {
        "command": "python scripts/load_context.py"
      }
    ]
  }
}
```

### 可用Hook类型

| Hook | 触发时机 | 用途 |
|------|----------|------|
| PreToolUse | 工具调用前 | 验证/拦截 |
| PostToolUse | 工具调用后 | 后处理/统计 |
| Stop | 会话结束时 | 保存状态/总结 |
| SessionStart | 会话开始时 | 加载上下文/恢复状态 |

### 写作场景Hook示例

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "command": "node scripts/on-chapter-save.js \"$FILE_PATH\"",
        "description": "章节保存后自动: 更新字数/提取事实/更新Bible"
      }
    ],
    "SessionStart": [
      {
        "command": "node scripts/load-novel-state.js",
        "description": "会话开始时加载: 进度/上次摘要/待处理事项"
      }
    ],
    "Stop": [
      {
        "command": "node scripts/save-session-summary.js",
        "description": "会话结束时保存: 本次进度/决策记录/下次计划"
      }
    ]
  }
}
```

---

## Plugin打包 (.claude-plugin/)

### Plugin结构

```
my-novel-plugin/
├── plugin.json            # 插件元数据
├── .claude/
│   ├── skills/
│   │   ├── write/SKILL.md
│   │   ├── review/SKILL.md
│   │   └── plan/SKILL.md
│   ├── agents/
│   │   ├── writer.md
│   │   └── reviewer.md
│   └── settings.json     # 插件级设置
├── scripts/
│   ├── update-bible.js
│   ├── check-consistency.js
│   └── export-epub.js
├── templates/
│   ├── character-card.yaml
│   ├── world-bible.yaml
│   └── chapter-outline.md
└── README.md
```

### plugin.json

```json
{
  "name": "novel-writing-toolkit",
  "version": "1.0.0",
  "description": "AI长篇小说写作工具包",
  "author": "your-name",
  "skills": [
    ".claude/skills/write/SKILL.md",
    ".claude/skills/review/SKILL.md",
    ".claude/skills/plan/SKILL.md"
  ],
  "agents": [
    ".claude/agents/writer.md",
    ".claude/agents/reviewer.md"
  ],
  "hooks": {
    "PostToolUse": [...]
  },
  "dependencies": {
    "node": ">=18",
    "python": ">=3.9"
  }
}
```

---

## 最佳实践 10条

### 1. 技能描述要精确
```
❌ description: "写小说"
✅ description: "根据大纲和Story Bible生成网文章节，包含爽点设计和章尾钩子"
```

### 2. 使用子Agent隔离复杂任务
```
主Agent: 协调流程
子Agent(fork): 执行具体写作/审查
好处: 上下文隔离，专注度高
```

### 3. 文件系统即状态
```
用文件存储状态，不依赖内存:
  .novel/progress.json  # 进度
  .novel/bible.yaml     # Bible
  chapters/*.md         # 章节
  summaries/*.md        # 摘要
```

### 4. Hook处理副作用
```
写入章节 → Hook自动:
  - 更新字数统计
  - 提取事实
  - 更新进度
不需要Claude记住做这些事
```

### 5. 模板化重复操作
```
templates/ 目录存放:
  - 角色卡模板
  - 章节大纲模板
  - 审查清单模板
  - 风格规范模板
```

### 6. 渐进式加载上下文
```
不要一次加载所有信息:
  Tier 1: 核心设定(alwaysApply)
  Tier 2: 当前章节相关(动态加载)
  Tier 3: 按需检索(Read/Search)
```

### 7. 版本控制一切
```
Git管理:
  - Story Bible的每次更新
  - 章节的修订历史
  - 大纲的调整记录
  - 审查报告存档
```

### 8. 错误恢复设计
```
每步操作都要考虑:
  - 如果中断了如何恢复？
  - 进度保存在哪里？
  - 检查点机制
```

### 9. 分离关注点
```
每个Skill只做一件事:
  plan skill: 只做规划
  write skill: 只做写作
  review skill: 只做审查
通过主流程协调
```

### 10. 人工干预点
```
在关键节点等待人工确认:
  - 大纲审批
  - 关键剧情决策
  - 质量不达标时
  - 方向性选择
```
