# 多Agent架构对比

各项目的Agent角色设计、架构模式和流水线对比详解。

---

## Agent角色对比总表

### InkOS — 10-Agent流水线

| Agent | 角色 | 职责 |
|-------|------|------|
| Radar | 雷达 | 扫描市场/题材/读者偏好，输入灵感源 |
| Planner | 规划师 | 总体规划，章节分配，节奏设计 |
| Composer | 构思者 | 创意发散，场景构思，情节设计 |
| Architect | 架构师 | 结构设计，故事线编织，伏笔布局 |
| Writer | 写手 | 正文生成，对话写作，描写展开 |
| Observer | 观察者 | 实时监控生成质量，标记问题 |
| Reflector | 反思者 | 回顾已生成内容，评估整体方向 |
| Normalizer | 规范者 | 风格统一，格式标准化，术语一致 |
| Auditor | 审计员 | 33维审计检查，一致性验证 |
| Reviser | 修订者 | 根据审计结果修改问题段落 |

**流水线**: Radar→Planner→Composer→Architect→Writer→Observer→Reflector→Normalizer→Auditor→Reviser（闭环回Writer）

**核心特点**: 审计-修订闭环是质量保证核心；7个真相文件维护全局一致性

---

### BMAD Book Builder — 8-Agent三模态

| Agent | 角色 | 职责 |
|-------|------|------|
| Story Architect | 故事建筑师 | 总体结构设计，情节弧线规划 |
| Character Keeper | 角色守护者 | 角色一致性维护，性格发展追踪 |
| Style Coach | 风格教练 | 文风统一，TTR>0.175量化控制 |
| Chapter Writer | 章节写手 | 正文生成 |
| Continuity Editor | 连续性编辑 | 前后一致性检查 |
| Thematic Weaver | 主题编织者 | 主题线索管理，象征和隐喻追踪 |
| Rhythm Monitor | 节奏监控 | 叙事节奏分析和调整 |
| Documentaliste | 档案员 | 5维Bible维护，文档更新 |

**三模态**: Create（创建）/ Edit（编辑）/ Validate（验证）
**17个工作流**: 分布在三个模态中

**核心特点**: 量化风格控制（TTR>0.175）；5维Bible（角色/世界/情节/主题/风格）

---

### Terminal Velocity — 10-Agent自主

| Agent | 角色 | 职责 |
|-------|------|------|
| Specifications | 规格 | 定义写作规格和要求 |
| Production | 生产 | 执行内容生产 |
| Management | 管理 | 协调其他Agent，资源分配 |
| Evaluation | 评估 | 质量评估和反馈 |
| Chronicler | 编年史家 | 记录生成过程和决策 |
| Researcher | 研究者 | 背景资料收集和验证 |
| Deduplication | 去重 | 检测和消除重复内容 |
| Redundancy | 冗余 | 确保关键信息有冗余备份 |
| Integration | 集成 | 将各部分整合为连贯整体 |
| Writing | 写作 | 最终文本生成 |

**架构**: KinOS v6操作系统级框架，Agent完全自主运行
**成果**: 2个月5972次commit，零人工，10万字

**核心特点**: 完全自主（零人工干预）；去重和冗余Agent对抗退化

---

### claude-novel-writeFlow — 4+3 并行+闭环

**并行头脑风暴阶段（4 Agent）**:
| Agent | 职责 |
|-------|------|
| Agent 1 | 创意方向A（如：注重冲突） |
| Agent 2 | 创意方向B（如：注重角色） |
| Agent 3 | 创意方向C（如：注重悬念） |
| Agent 4 | 创意方向D（如：注重世界观） |

**写作审核闭环（3 Agent）**:
| Agent | 职责 |
|-------|------|
| Writer | 基于选定方案生成正文 |
| Reviewer | 审查质量/一致性/风格 |
| Reviser | 根据审查意见修改 |

**命令**: /outline → /style → /write → /export

**核心特点**: 并行发散→汇聚选择→串行精修；头脑风暴解决创意单一问题

---

### Novel Engine — 7-Agent × 14阶段

| Agent | 名称含义 | 职责 |
|-------|----------|------|
| Spark | 火花 | 概念/创意生成，初始灵感 |
| Verity | 真相 | 事实验证，一致性检查，逻辑验证 |
| Ghostlight | 幽光 | 氛围控制，语调设定，情绪管理 |
| Lumen | 光明 | 清晰度优化，可读性提升 |
| Forge | 锻造 | 结构构建，情节锻造，紧密度 |
| Sable | 暗色 | 潜文本管理，暗线控制，未言之意 |
| Quill | 羽笔 | 最终润色，文字工匠级精修 |

**14阶段流水线**: 每章经过14个阶段处理
**Motif账本**: 追踪主题/意象/象征的使用和发展

**核心特点**: 阶段数最多（14）；Motif账本保证主题一致性；暗线(Sable)Agent独特

---

### autonovel NousResearch — 5层+双免疫

**5个共演化层**:
| 层级 | 名称 | 职责 |
|------|------|------|
| Layer 1 | 概念层 | 高层概念和主题 |
| Layer 2 | 结构层 | 情节结构和弧线 |
| Layer 3 | 场景层 | 场景设计和转换 |
| Layer 4 | 文本层 | 正文生成 |
| Layer 5 | 审查层 | 质量审查和修订 |

**双免疫系统**:
| 免疫层 | 机制 | 职责 |
|--------|------|------|
| 正则规则层 | 正则表达式+规则 | 快速过滤：重复/格式/禁词/逻辑错误 |
| LLM判官层 | Claude Opus评估 | 深度评估：创意/一致性/文学质量 |

**核心特点**: "免疫系统"隐喻；双层过滤效率高；Opus做最终仲裁

---

### knowrite — 7-Agent接力

| Agent | 角色 | 职责 |
|-------|------|------|
| Writer | 写手 | 生成初稿 |
| Editor | 编辑 | 结构/逻辑/文字修改 |
| Humanizer | 人性化 | 去AI味，增加人感 |
| Proofreader | 校对 | 语法/标点/格式检查 |
| Reader | 读者 | 模拟读者反馈 |
| Summarizer | 摘要 | 更新章节摘要和记忆 |
| Fitness | 适配度 | 5维评分决定是否通过 |

**流程**: Writer→Editor→Humanizer→Proofreader→Reader→Fitness（<80%回Writer）

**核心特点**: 80%通过率阈值；纯JS向量；去AI味作为独立Agent

---

### Novalist — 6-Agent专业分工

| Agent | 角色 | 职责 |
|-------|------|------|
| Story Architect | 故事架构师 | 总体结构设计 |
| Character Developer | 角色开发者 | 角色创建和发展 |
| World Builder | 世界构建者 | 世界观设计和维护 |
| Plot Weaver | 情节编织者 | 情节线编织和推进 |
| Prose Writer | 散文写手 | 正文/文学质量 |
| Editor | 编辑 | 最终审查和修改 |

**架构**: AWS Bedrock + Strands SDK编排

**核心特点**: Agent命名清晰直觉；Strands SDK新编排框架；AWS云原生

---

### daer-novel — 7-Agent异步

- 7个Agent通过BullMQ异步队列通信
- WebSocket实时推送生成进度
- PostgreSQL + pgvector存储
- Tauri桌面应用

**核心特点**: 异步队列解耦Agent；实时推送用户体验好；桌面应用

---

### Nai — 3-Agent知识图谱

| Agent | 角色 | 职责 |
|-------|------|------|
| World Agent | 世界 | 世界观管理和维护 |
| Character Agent | 角色 | 角色状态和发展 |
| Plot Agent | 情节 | 情节推进和控制 |

**架构**: Neo4j知识图谱 + LangGraph编排 + LlamaIndex检索
**特色**: 情感状态机 + 规则引擎 + BM25+向量混合检索

**核心特点**: 最简Agent设计（只有3个）；知识图谱为核心；规则引擎约束

---

## 核心架构模式分类

### 模式一：流水线式（Pipeline）

```
Input → Agent1 → Agent2 → Agent3 → ... → Output
```

**代表项目**: InkOS, Novel Engine, knowrite
**特点**:
- 线性顺序执行
- 每个Agent有明确输入/输出接口
- 简单可靠，易于调试
- 适合标准化流程

**优势**: 可预测、可复现、易于扩展新阶段
**劣势**: 错误累积、灵活性不足

---

### 模式二：闭环审核式（Review Loop）

```
Writer → Reviewer → [Pass?] → Output
                  ↓ [Fail]
              Reviser → Writer（重试）
```

**代表项目**: BMAD, autonovel, claude-novel-writeFlow, knowrite
**特点**:
- 生成→审查→修订循环
- 质量门控（通过率阈值）
- 多轮迭代直到达标
- 审计是质量保证核心

**优势**: 质量可控、可设定标准
**劣势**: 成本高（多轮调用）、可能陷入循环

---

### 模式三：角色分工 + 人工介入式（Collaborative）

```
     ┌─ Agent A ─┐
Input│  Agent B  │→ Human Decision → Next Phase
     └─ Agent C ─┘
```

**代表项目**: claude-novel-writeFlow(并行阶段), writeAgent, ElyHa
**特点**:
- 多Agent并行生成方案
- 人工在关键节点决策
- Ghost-node模式（AI提议，人类采纳）
- 适合创意性强的环节

**优势**: 创意多样性、人工把控方向
**劣势**: 需要人工参与、无法全自动

---

### 模式四：层级递进式（Hierarchical）

```
概念层 → 结构层 → 场景层 → 文本层 → 审查层
  ↑                                      ↓
  └──────────── 反馈修正 ────────────────┘
```

**代表项目**: autonovel(5层共演化), Openwrite(四级大纲), Plan-Write-Revise论文
**特点**:
- 从抽象到具体逐层展开
- 每层约束下一层
- 上层修改可触发下层重写
- 对应"雪花法"等写作方法论

**优势**: 结构清晰、约束传递
**劣势**: 上层错误影响全局、重写成本高

---

### 模式五：自主涌现式（Autonomous）

```
Agent1 ←→ Agent2 ←→ Agent3
  ↕          ↕          ↕
Agent4 ←→ Agent5 ←→ Agent6
（自主通信、自主决策）
```

**代表项目**: Terminal Velocity(零人工), KinOS
**特点**:
- Agent间自主通信
- 无固定流程
- 涌现式协作
- 完全自主运行

**优势**: 无需人工、可长期运行
**劣势**: 不可预测、质量难控、调试困难

---

## 核心洞察

### 1. 审计/修订闭环是质量保证的核心

几乎所有高Stars项目都包含某种形式的审计-修订循环：
- InkOS: Auditor → Reviser
- BMAD: Validate模态
- autonovel: 双免疫系统
- knowrite: Fitness Agent 80%阈值
- claude-novel-writeFlow: Reviewer → Reviser

**结论**: 无审核的单次生成不足以保证长篇质量

### 2. Agent数量与复杂度的平衡

| Agent数量 | 代表 | 适用场景 |
|-----------|------|----------|
| 3 | Nai | 简单项目/原型验证 |
| 4-6 | Novalist, writeFlow | 中等复杂度/实用 |
| 7-8 | BMAD, Novel Engine, knowrite | 高质量要求 |
| 10+ | InkOS, Terminal Velocity | 极致质量/实验性 |

**结论**: 6-8个Agent是实用与质量的最佳平衡点

### 3. 专业化分工的维度

常见的Agent职能维度：
- **创意维度**: Brainstormer/Spark/Composer
- **结构维度**: Architect/Planner/Plot Weaver
- **写作维度**: Writer/Prose Writer
- **一致性维度**: Continuity Editor/Verity/Character Keeper
- **风格维度**: Style Coach/Normalizer/Ghostlight
- **审查维度**: Auditor/Reviewer/Editor/Fitness
- **记忆维度**: Summarizer/Documentaliste/Chronicler
- **修订维度**: Reviser/Editor

### 4. 信息流设计是架构核心

Agent间如何传递信息决定了系统质量：
- **共享文件**: novel-bot (SOUL.md/WORLD.md)
- **共享数据库**: saga/Nai (Neo4j)
- **消息队列**: daer-novel (BullMQ)
- **状态图**: LangGraph项目
- **7真相文件**: InkOS

### 5. 去AI味需要专门Agent

成功的项目把"去AI味"作为独立的Agent或阶段：
- knowrite: Humanizer Agent
- autonovel: 双免疫系统
- NovelWriter_public: 去AI味模块
- 非凡写作: 专门的去AI味步骤
