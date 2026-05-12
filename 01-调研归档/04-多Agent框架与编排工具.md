# 多Agent框架与编排工具

9个主要框架 + 支撑工具的详细分析，及推荐组合方案。

---

## 1. CrewAI

- **官网**: https://www.crewai.com
- **GitHub Stars**: 25k+
- **定位**: 最易用的多Agent编排框架

### 核心概念

- **Crews**: Agent团队，定义Agent集合和协作方式
- **Flows**: 工作流编排，定义任务执行顺序和条件分支
- **YAML定义Agent**: 声明式配置，低代码定义Agent角色和能力
- **统一记忆系统**: 短期/长期/实体记忆自动管理

### 官方写作示例

CrewAI官方有 "Write a Book with Flows" 示例：
```
Flow: 
  1. outline_crew → 生成大纲
  2. write_chapter_crew × N → 逐章写作
  3. edit_crew → 全书编辑
  4. publish_crew → 格式化输出
```

### 适用场景

- 快速原型验证
- 中等复杂度的多Agent系统
- 需要声明式配置的团队

### 优缺点

- **优势**: 学习曲线低、官方示例多、社区活跃、YAML配置直觉
- **劣势**: 灵活性不如LangGraph、复杂分支逻辑受限、记忆系统不够深

---

## 2. AutoGen (AgentChat)

- **GitHub Stars**: 40k+ (Microsoft)
- **定位**: 微软开源的多Agent对话框架

### 核心概念

- **AgentChat**: Agent间对话框架
- **团队模式**:
  - **RoundRobin**: 轮流发言
  - **Selector**: 动态选择下一个发言Agent
  - **Swarm**: 蜂群模式，根据handoff规则转移控制
  - **MagenticOne**: 微软通用Agent团队（Orchestrator + WebSurfer + FileSurfer + Coder + Terminal）
- **AgentTool嵌套**: Agent可以作为其他Agent的工具被调用

### 写作应用

```
RoundRobin模式:
  Writer → Critic → Editor → Writer(修订) → ...

Selector模式:
  Orchestrator选择: 
    需要世界观？→ WorldBuilder
    需要角色？→ CharacterDev
    需要写作？→ Writer
    需要审查？→ Critic
```

### 适用场景

- Agent间需要复杂对话
- 需要动态选择Agent的场景
- 微软生态集成

### 优缺点

- **优势**: 对话模式丰富、Agent嵌套强大、微软支持
- **劣势**: 学习曲线较陡、概念较多、debug困难

---

## 3. LangGraph

- **GitHub Stars**: 8k+ (LangChain团队)
- **定位**: 最灵活的有状态Agent图编排

### 核心概念

- **有状态图**: 节点(Agent/函数) + 边(条件/无条件) 构成有向图
- **持久执行**: 执行状态可持久化，支持长时间运行
- **检查点**: 任意时间点保存/恢复执行状态
- **人机协作循环**: 内建interrupt/resume机制

### 写作应用

```python
# LangGraph写作流水线示例
from langgraph.graph import StateGraph

graph = StateGraph(NovelState)

# 定义节点
graph.add_node("planner", plan_chapter)
graph.add_node("writer", write_content)
graph.add_node("reviewer", review_content)
graph.add_node("reviser", revise_content)
graph.add_node("human_review", wait_for_human)

# 定义边
graph.add_edge("planner", "writer")
graph.add_edge("writer", "reviewer")
graph.add_conditional_edges("reviewer", 
    route_review,  # 质量判断函数
    {"pass": "human_review", "fail": "reviser"}
)
graph.add_edge("reviser", "writer")  # 重写循环
graph.add_edge("human_review", "planner")  # 下一章
```

### 适用场景

- 复杂分支逻辑
- 需要人机协作的节点
- 长时间运行任务（写整本书）
- 需要断点续写

### 优缺点

- **优势**: 最灵活、状态管理最强、检查点/恢复、人机协作原生支持
- **劣势**: 学习曲线高、需要理解图概念、代码量较大

---

## 4. MetaGPT

- **GitHub Stars**: 50k+
- **定位**: "Code = SOP(Team)" — 让Agent遵循SOP产出结构化中间产物

### 核心概念

- **核心公式**: Code = SOP(Team)
- **角色遵循SOP**: 每个角色有明确的标准操作流程
- **结构化中间产物**: Agent间传递结构化文档（PRD/设计/代码）

### 写作应用

```
SOP: 小说写作流程
  
角色1(策划): 
  输入: 用户需求
  SOP: 市场分析 → 类型选择 → 核心创意
  输出: 《策划书》(结构化JSON)

角色2(架构师):
  输入: 《策划书》
  SOP: 世界观设计 → 角色设计 → 大纲设计
  输出: 《设计文档》(结构化JSON)

角色3(写手):
  输入: 《设计文档》+ 章节号
  SOP: 上下文组装 → 正文生成 → 自检
  输出: 《章节草稿》

角色4(编辑):
  输入: 《章节草稿》+ 《设计文档》
  SOP: 一致性检查 → 文风检查 → 修改建议
  输出: 《审稿意见》或《定稿》
```

### 适用场景

- 需要结构化产出的流程
- 团队协作模拟
- 需要标准化中间文档

### 优缺点

- **优势**: SOP概念清晰、结构化产出、适合标准化流程
- **劣势**: 灵活性受SOP限制、创意写作可能过于rigid

---

## 5. Swarms

- **GitHub Stars**: 20k+
- **定位**: 最丰富的编排模式集合

### 核心编排模式

| 模式 | 说明 | 写作适用 |
|------|------|----------|
| Sequential | 顺序执行 | 章节流水线 |
| Concurrent | 并行执行 | 多章同时生成 |
| AgentRearrange | 动态重排 | 根据需要调整顺序 |
| Graph | 图编排 | 复杂依赖关系 |
| MoA (Mixture of Agents) | 混合专家 | 多Agent投票选最佳 |
| GroupChat | 群聊 | Agent讨论创意 |
| Hierarchical | 层级 | 主编→编辑→写手 |
| Heavy | 重型 | 大规模并行 |
| SwarmRouter | 路由 | 动态路由到合适Agent |

### 写作应用

```
# MoA模式用于创意选择
MoA:
  Agent1(玄幻专家) → 方案A
  Agent2(都市专家) → 方案B
  Agent3(悬疑专家) → 方案C
  Aggregator → 选择/融合最佳

# Hierarchical模式用于生产
Hierarchical:
  主编(Director) 
    → 编辑1(负责卷1-3) 
      → 写手A, 写手B
    → 编辑2(负责卷4-6)
      → 写手C, 写手D
```

### 优缺点

- **优势**: 模式最多最灵活、适合实验不同架构
- **劣势**: 选择困难、文档不够完善、不如LangGraph成熟

---

## 6. Claude Tool Use

- **提供方**: Anthropic
- **定位**: 原生工具循环 + MCP协议

### 核心概念

- **工具循环**: Claude原生支持调用工具并处理结果
- **MCP协议**: Model Context Protocol，标准化外部工具接口
- **Strict Schema**: 严格的JSON Schema约束工具参数
- **多轮工具调用**: 自动循环直到完成任务

### 写作应用

```
Claude Agent + Tools:
  - write_chapter(outline, style, context) → 章节文本
  - check_consistency(chapter, bible) → 一致性报告
  - update_bible(chapter, bible) → 更新后的bible
  - search_context(query, vector_db) → 相关片段
  - evaluate_quality(chapter, criteria) → 评分

工作流:
  Claude自主决定调用顺序:
  1. search_context("上一章结尾") → 获取上下文
  2. write_chapter(outline[i], style, context) → 生成章节
  3. check_consistency(chapter, bible) → 检查
  4. [如果有问题] write_chapter(重写) → 修正
  5. update_bible(chapter, bible) → 更新
```

### 优缺点

- **优势**: 原生集成最简单、Claude创意质量高、MCP生态丰富
- **劣势**: 单模型限制、成本较高、无内建多Agent机制

---

## 7. GPT-Author

- **GitHub Stars**: 2.5k
- **定位**: 最简可行流水线示范

### 核心流程

```
最简流水线:
1. generate_plots(prompt, n=5) → 5个情节方案
2. select_best(plots) → 最佳情节
3. improve_plot(best_plot) → 改进版
4. create_storyline(plot) → 章节故事线
5. write_chapters(storyline) → 逐章写作
6. generate_cover(title, summary) → 封面
7. create_epub(chapters, cover) → EPUB文件
```

### 参考价值

- 证明了最简单的流水线就能产出完整书
- 成本约$4/15章（使用GPT-4）
- 适合作为基础框架进行扩展
- 核心不足：无记忆管理、无一致性检查、无质量审核

---

## 8. GPT-Researcher

- **GitHub Stars**: 18k+
- **定位**: 规划+并行执行Agent模式

### 核心概念

- **Planner Agent**: 分解研究任务为子任务
- **Researcher Agents**: 并行执行各子任务
- **Writer Agent**: 汇总研究结果生成报告

### 写作应用（世界观调研阶段）

```
用于小说前期调研:
  Planner: "构建修仙世界观需要研究什么？"
    → 子任务1: 中国传统修仙体系
    → 子任务2: 现有修仙小说的体系分析
    → 子任务3: 修仙等级设计参考
    → 子任务4: 门派/宗门组织结构
    → 子任务5: 法宝/功法/丹药体系

  Researcher × 5: 并行搜索和总结
  
  Writer: 汇总为《修仙世界观设计参考手册》
```

### 优缺点

- **优势**: 并行效率高、信息收集全面
- **劣势**: 专为研究设计，需要适配写作场景

---

## 9. ChatDev

- **GitHub Stars**: 30k+
- **定位**: "虚拟公司"隐喻，SOP驱动角色分配

### 核心概念

- **虚拟公司**: 多Agent模拟公司组织结构
- **SOP驱动**: 标准操作流程定义协作方式
- **角色分配**: CEO/CTO/程序员/设计师/测试员
- **聊天链**: Agent间通过结构化对话协作

### 写作应用

```
虚拟出版社:
  总编辑(CEO) → 定方向
  策划编辑(CTO) → 定结构
  签约作家(程序员) → 写内容
  美术编辑(设计师) → 配图/封面
  审读编辑(测试员) → 质量检查
  
SOP:
  选题会 → 策划案 → 大纲审批 → 写作 → 三审 → 发布
```

### 优缺点

- **优势**: 隐喻清晰、角色明确、SOP严格
- **劣势**: 过于代码开发导向，需要大量改造适配写作

---

## 支撑工具

### Letta (MemGPT)

- **功能**: 长期记忆管理
- **核心**: Core Memory + Working Memory + Archival Memory三层架构
- **写作用途**: 管理角色状态、世界设定、情节进展的长期记忆
- **集成**: 可作为任何框架的记忆层

### DSPy

- **功能**: 提示工程自动优化
- **核心**: 将提示优化为可训练的模块
- **写作用途**: 优化写作提示的质量、一致性
- **集成**: 优化各Agent的提示模板

### LiteLLM

- **功能**: 统一LLM接口
- **核心**: 100+模型统一API调用
- **写作用途**: 多模型路由（创意用Claude，批量用DeepSeek）
- **集成**: 所有框架的模型层统一

### AgentStack

- **功能**: Agent项目脚手架
- **核心**: CLI快速创建Agent项目模板
- **写作用途**: 快速搭建写作Agent项目
- **集成**: 与CrewAI/LangGraph等框架配合

### Rivet

- **功能**: 可视化Agent图编辑
- **核心**: 节点式拖拽编辑Agent流程
- **写作用途**: 可视化设计写作流水线
- **集成**: 导出为可执行的Agent图

---

## 推荐组合方案

### 方案一：快速启动（中等复杂度）

```
CrewAI Flows 编排
  + Claude 创意生成（正文/审查）
  + LiteLLM 多模型路由
  + ChromaDB 向量检索
```

**适合**: 快速验证想法、中等质量要求

### 方案二：高质量长篇（高复杂度）

```
LangGraph 复杂分支编排
  + Claude Opus 创意生成
  + Letta(MemGPT) 长期记忆
  + Neo4j 知识图谱
  + DSPy 提示优化
```

**适合**: 追求最高质量、有技术能力

### 方案三：Claude Code原生（最简集成）

```
Claude Code Skills 编排入口
  + 子Agent(context: fork) 分工
  + 文件系统状态管理
  + MCP工具扩展
  + Hooks自动化
```

**适合**: Claude Code用户、快速迭代、低基础设施

### 方案四：成本优化（大规模生产）

```
CrewAI Flows 编排
  + DeepSeek/Qwen 批量生成（低成本）
  + Claude 关键审核（高质量）
  + ChromaDB 记忆检索
  + 本地Qwen2.5-72B 去AI味
```

**适合**: 网文批量生产、成本敏感

---

## 框架选择决策树

```
需要多Agent协作？
├── 是 → 需要复杂分支/人机协作？
│   ├── 是 → LangGraph
│   └── 否 → 需要最快上手？
│       ├── 是 → CrewAI
│       └── 否 → 需要丰富编排模式？
│           ├── 是 → Swarms
│           └── 否 → MetaGPT(SOP) / AutoGen(对话)
└── 否 → 单Agent + 工具足够？
    ├── 是 → Claude Tool Use
    └── 否 → 最简流水线验证？
        └── 是 → GPT-Author模式
```
