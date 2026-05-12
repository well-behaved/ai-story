# AI 长篇网络小说写作 - 全面调研报告

> 调研时间：2026-05-12
> 调研范围：GitHub 项目、商业产品、学术论文、社区讨论（Reddit/HN/知乎/小红书）、写作方法论、技术方案
> 子 Agent 数量：15+，覆盖 22 个搜索方向

---

## 一、最值得参考的开源项目

### Tier 1：成熟项目（1000+ Stars）

| 项目 | Stars | 核心架构 | 链接 |
|------|-------|---------|------|
| **InkOS** | 6k | 10-Agent 流水线 + 7个真相文件 + 33维审计 | https://github.com/Narcooo/inkos |
| **AI_NovelGenerator** | 4.9k | 多阶段章节生成+向量语义搜索+自动校对 | https://github.com/YILING0013/AI_NovelGenerator |
| **KoboldAI** | 3.9k | 浏览器前端+多模型后端+Memory/WorldInfo系统 | https://github.com/KoboldAI/KoboldAI-Client |
| **AI-Writer (RWKV)** | 3.7k | RWKV模型专训网文语料 | https://github.com/BlinkDL/AI-Writer |
| **gpt-author** | 2.5k | 最简流水线→EPUB，~$4生成15章 | https://github.com/mshumer/gpt-author |
| **AI-Novel-Writing-Assistant** | 1.2k | LangChain/LangGraph + RAG(Qdrant) + 自动导演 | https://github.com/ExplosiveCoderflome/AI-Novel-Writing-Assistant |
| **Long-Novel-GPT** | 1.1k | 三阶段扩展(200→1000→2000字)+50线程并行 | https://github.com/MaoXiaoYuZ/Long-Novel-GPT |
| **Terminal Velocity** | 1.1k | 10个自主 Agent，2个月写完10万字，零人工 | https://github.com/mind-protocol/terminal-velocity |
| **RecurrentGPT** | 1k | 语言级RNN记忆，理论无限长，学术论文实现 | https://github.com/aiwaves-cn/RecurrentGPT |
| **autonovel (NousResearch)** | 922 | 5共演化层+双免疫系统+Opus审查+PDF/ePub/有声书 | https://github.com/NousResearch/autonovel |
| **Kimi Writer** | 567 | 极简单 Agent + 200k上下文 + 自动压缩 | https://github.com/Doriandarko/kimi-writer |
| **oh-story-claudecode** | 997 | Claude Code网文技能包，6skills+4agent对抗审查+封面生成 | https://github.com/worldwonderer/oh-story-claudecode |
| **NovelForge** | 801 | 卡片系统+JSON Schema结构化生成+@DSL上下文注入+Neo4j | https://github.com/RhythmicWave/NovelForge |
| **NovelClaw** | 304 | 结构化写作工作台 + 记忆管理 + 手稿审查 | https://github.com/iLearn-Lab/NovelClaw |

### Tier 1.5：英文中等项目（100-999 Stars）

| 项目 | Stars | 亮点 | 链接 |
|------|-------|------|------|
| **gemini-writer** | 277 | Gemini 3 Flash 1M上下文+自动压缩 | https://github.com/Doriandarko/gemini-writer |
| **ai-novel-generator (雪花法)** | 221 | 雪花法规划+去AI味重写+商业版 | https://github.com/yangqi1309134997-coder/ai-novel-generator |
| **vela** | 196 | 本地优先AI写作IDE+百万字RAG+SQLite | https://github.com/heider-x/vela |
| **creative-writing-skills** | 169 | Claude Code 13个写作技能+多Agent(muse编排) | https://github.com/haowjy/creative-writing-skills |
| **arrows** | 159 | 零UI，段落级生成，双续写并行选择 | https://github.com/p-e-w/arrows |
| **Writingway** | 154 | PyQt5 GUI+LangChain+FAISS+spaCy | https://github.com/aomukai/Writingway |
| **storycraftr** | 135 | CLI工具+VSCode扩展+本地嵌入 | https://github.com/raestrada/storycraftr |
| **NovelGenerator** | 126 | 多线程叙事+情感弧线+时间线同步 | https://github.com/KazKozDev/NovelGenerator |
| **saga** | 106 | Neo4j知识图谱+LangGraph+矛盾检测 | https://github.com/Lanerra/saga |
| **Claude-Book** | 76 | Claude Code多Agent+困惑度改善器+ePub生成 | https://github.com/ThomasHoussin/Claude-Book |
| **knowrite** | 14 | 7Agent接力+5维适配度+三层记忆+纯JS向量 | https://github.com/knoai/knowrite |

### Tier 2：中小但有特色的项目（中文）

| 项目 | Stars | 亮点 | 链接 |
|------|-------|------|------|
| **Openwrite** | 107 | Python CLI，双Agent(Goethe规划+Dante写作)，四级大纲 | https://github.com/LiPu-jpg/Openwrite |
| **Lorn.NovelWriteSkills** | 51 | 最完整的写作资产库，全流程覆盖，多平台适配 | https://github.com/lornshrimp/Lorn.NovelWriteSkills |
| **BMAD Book Builder** | 27 | 8个专门化Agent + 量化风格指标(TTR等) + 17个工作流 | https://github.com/jblemee/bmad-book-builder |
| **Morpheus** | 29 | 三层记忆系统(L1/L2/L3) + 冲突检测 | https://github.com/papysans/Morpheus |
| **ElyHa** | 21 | 图优先的可视化小说写作，节点式绘图 | https://github.com/ShadowLoveElysia/ElyHa |

### 新发现的重要项目（第三轮补充 - B站/YouTube调研）

| 项目 | Stars | 亮点 | 链接 |
|------|-------|------|------|
| **AI_Gen_Novel** | 416 | 基于RecurrentGPT概念的多Agent+网文类型知识 | https://github.com/cjyyx/AI_Gen_Novel |
| **AIxiezuo** | 349 | LangChain+章节状态JSON+多版本对比 | https://github.com/yefeng2renxing/AIxiezuo |
| **Dramatica-Flow** | 136 | 因果链引擎+情感弧追踪(1-10)+信息边界防全知 | https://github.com/ydsgangge-ux/dramatica-flow |
| **ReNovel-AI** | 113 | 小说润色(非生成)+三模型协作+SillyTavern兼容 | https://github.com/BiranSama/ReNovel-AI |

### B站热门AI写小说教程

| 视频 | 播放量 | 核心内容 |
|------|--------|---------|
| 檀东东 "一套连招释放AI写作能力" | **184万** | 进阶提示词工程组合技 |
| 非凡写作 "AI写小说流程拆解45分钟" | **32万** | 扫榜→对标书大纲→细纲→正文 |
| 林彼丢 "生成百万字后的实践反思" | **27.5万** | DeepSeek/Claude实战经验+去AI味 |
| 笔灵AI "全自动写小说工具" | **12.7万** | 笔灵AI商业工具演示 |
| 阿尔法坦克 "扣子工作流自动写小说" | **4.7万** | Coze工作流搭建教程 |
| 普通程序员 "9分钟零基础AI写长篇" | **4.9万** | WriterHelper(Trae插件)+Agent系统 |

### 新发现的重要项目（第二轮补充）

| 项目 | Stars | 亮点 | 链接 |
|------|-------|------|------|
| **Write-Agent** | 新 | 分层记忆P0-P6+伏笔追踪+情报提取+SSE流式 | https://github.com/CuriosityTomorrow/write-agent |
| **Novel Writer Suite** | 新 | 零成本(免费API)，已验证90万字仙侠小说 | https://github.com/Shine8592/novel-writer-skills |
| **novelist-workbench** | 新 | Claude Code深度集成，8内置Skills，串行逐章 | https://github.com/huahaiwujiang/novelist-workbench |
| **Novalist** | 新 | AWS Bedrock+6专业Agent+Strands SDK | https://github.com/Crazyhenry123/novalist |
| **novel-gen-platform** | 新 | Story State Core+4-Agent闭环+局部重写 | https://github.com/seven2248/novel-gen-platform |
| **AI_Gen_Novel_Style_RAG** | 新 | RAG风格学习，智能分块(对话/描写/动作) | https://github.com/cs2764/AI_Gen_Novel_Style_RAG |

### 新发现的中文项目（第一轮补充）

| 项目 | Stars | 亮点 | 链接 |
|------|-------|------|------|
| **AI-Writer** (BlinkDL) | 3.7k | RWKV模型，专训网文语料 | https://github.com/BlinkDL/AI-Writer |
| **Long-Novel-GPT** | 1.1k | RAG+自定义提示，百万字生成，支持导入已有小说 | https://github.com/MaoXiaoYuZ/Long-Novel-GPT |
| **WenShape (文枢)** | 352 | 卡片系统+BM25事实摘要+多模型网关 | https://github.com/unitagain/WenShape |
| **51mazi (我要码字)** | 282 | Electron桌面应用，关系图谱/时间线/地图设计 | https://github.com/xiaoshengxianjun/51mazi |
| **ainovel-cli** | 165 | Go语言，3子Agent，500+章滚动规划，TUI界面 | https://github.com/voocel/ainovel-cli |
| **NovelKit** | 137 | 40+ slash命令，Cursor集成，"小说宪法"概念 | https://github.com/t59688/novel-kit |
| **天命 (tianming)** | 117 | .NET/WPF，12维事实快照+6道验证门+9种变更声明 | https://github.com/zy-zmc/tianming-novel-ai-writer |
| **daer-novel** | 71 | 7个Agent+BullMQ异步队列+WebSocket实时推送 | https://github.com/yuwangi/daer-novel |
| **ai-webnovel-workflow** | 13 | 五层瀑布模型，75个API路由，3种驱动模式 | https://github.com/sanshanjianke/ai-webnovel-workflow |
| **Nai** | 12 | Neo4j知识图谱+情感状态机+规则引擎一致性 | https://github.com/HXSLtim/Nai |

### Tier 3：Claude Code 专用

| 项目 | 亮点 | 链接 |
|------|------|------|
| **claude-novel-writeFlow** | Claude Code 插件，4Agent头脑风暴 + 3Agent写作审核闭环 | https://github.com/jinmawang/claude-novel-writeFlow |
| **novel-writing-skill** | Claude Code Skill 格式，10个模块化目录 | https://github.com/EchoAI-Design/novel-writing-skill |
| **creative-writing-skills** | 169 stars，13个写作技能，muse编排多Agent | https://github.com/haowjy/creative-writing-skills |
| **Novel Engine** | 7 Agent+14阶段编辑流水线+语音档案+motif账本 | https://github.com/john-paul-ruf/novel-engine |
| **GOAT-Storytelling-Agent** | 143 stars，开源GOAT-70B+场景级元数据生成 | https://github.com/GOAT-AI-lab/GOAT-Storytelling-Agent |

---

## 二、商业产品 & SaaS 工具

### 英文市场

| 工具 | 定价 | 核心特色 | 长篇处理方式 |
|------|------|---------|-------------|
| **Sudowrite** | $10/月 | Story Bible → Canvas → Write → Edit 全流程 | Story Bible 维护角色/情节一致性 |
| **NovelCrafter** | $4-20/月 | Codex 自动追踪 + 300+模型 + BYOK | Codex 自动跟踪提及/进展/角色关系 |
| **NovelAI** | $10-25/月 | Lorebook 关键词触发 + 专门微调模型 | Lorebook + Memory 字段持久注入 |
| **Squibler** | $16-49/月 | 从概念直接生成整书 | Elements 系统维护项目智能 |
| **Subtxt** | $20-250/月 | 32000+叙事结构 + Dramatica理论 | 实时主题分析维护连贯性 |
| **AutoCrit** | 免费起 | 20+编辑工具 + 系列分析器 | 跨书一致性检查 |

### 中文市场

| 工具 | 核心特色 |
|------|---------|
| **阅文妙笔** | 中国最大网文平台集成，理解网文类型惯例 |
| **秘塔写作猫** | AI写作助手，语法/风格校正 |
| **火山写作** | 字节跳动生态，接入豆包大模型 |

---

## 三、多 Agent 架构对比

### 各项目的 Agent 角色对比

| 角色 | InkOS | BMAD | Terminal Velocity | claude-novel-writeFlow |
|------|-------|------|-------------------|----------------------|
| 规划 | Radar + Planner | Story Architect | SpecificationsAgent | 4个并行头脑风暴Agent |
| 结构 | Composer + Architect | Thematic Weaver | IntegrationAgent | - |
| 写作 | Writer | Chapter Writer | WritingAgent + ProductionAgent | Writer Agent |
| 观察/提取 | Observer + Reflector | Documentaliste | ChroniclerAgent | - |
| 审核 | Auditor (33维) | Continuity Editor | EvaluationAgent | Style Reviewer + Continuity Reviewer |
| 修订 | Reviser + Normalizer | Style Coach + Rhythm Monitor | RedundancyAgent + DeduplicationAgent | 闭环修改(最多3轮) |
| 角色管理 | (真相文件) | Character Keeper | ResearcherAgent | - |

### 核心架构模式

```
最佳实践流水线：
  Planner → Architect → Writer → Observer → Auditor → Reviser
                                      ↑                    |
                                      +-------- 闭环 ------+
```

**关键洞察：审计/修订闭环是质量保证的核心。** 没有反馈循环的系统质量会快速退化。

---

## 四、记忆管理 & 一致性技术

### 推荐的混合架构（综合各方案）

```
Layer 1: 结构基础
  ├── 总纲 (全书主线)
  ├── 卷纲 (每卷目标)
  └── 章纲 (每章场景/冲突/钩子)

Layer 2: 记忆系统 (混合方案)
  ├── Story Bible (自动维护的 YAML/JSON)
  │   ├── 角色档案 (含时间状态)
  │   ├── 世界规则和事实
  │   └── 活跃情节线
  ├── 滚动摘要 (3级: 详细/中等/压缩)
  └── 向量数据库 (按场景分块+元数据标签)

Layer 3: 每章上下文组装
  1. 当前场景角色的 Story Bible 条目 (~1-2K tokens)
  2. 章节大纲/节拍表 (~500 tokens)
  3. 上一章详细摘要 (~800 tokens)
  4. RAG检索的相关段落 (~2-4K tokens)
  5. 相关世界规则 (~500 tokens)
  6. 最近故事弧摘要 (~1K tokens)

Layer 4: 生成后流水线
  1. 生成章节
  2. 提取事实/状态变更
  3. 更新 Story Bible
  4. 运行矛盾检查
  5. 更新摘要
  6. 标记问题供人工审查
```

### 10种一致性技术对比

| 技术 | 适用性 | 复杂度 | 推荐优先级 |
|------|--------|--------|-----------|
| Story Bible (自动维护) | 非常高 | 中 | ★★★★★ |
| 滚动摘要/渐进压缩 | 高 | 低 | ★★★★★ |
| 分层规划(Plan-Write-Revise) | 非常高 | 中 | ★★★★★ |
| 生成后一致性验证 | 高 | 低 | ★★★★☆ |
| RAG 检索增强 | 中高 | 中 | ★★★★☆ |
| 实体状态追踪 | 高(特定场景) | 高 | ★★★☆☆ |
| 知识图谱 | 中 | 高 | ★★★☆☆ |
| 多Agent架构 | 中 | 很高 | ★★★☆☆ |
| MemGPT分层记忆 | 高 | 高 | ★★★☆☆ |
| 上下文压缩 | 中高 | 中 | ★★★☆☆ |

---

## 五、写作方法论库

### 西方叙事结构

| 方法 | 核心步骤 | AI自动化适合度 |
|------|---------|---------------|
| **雪花法** (Snowflake) | 一句话→一段→角色→展开→场景表→初稿 | ★★★★★ 非常适合递进展开 |
| **Save the Cat 节拍表** | 15个结构节拍，映射到百分比位置 | ★★★★★ 结构化程度高 |
| **三幕结构** | 设置25%→对抗50%→解决25% + 转折点 | ★★★★☆ |
| **英雄之旅** (12阶段) | 普通世界→召唤→考验→回归 | ★★★★☆ |
| **Story Grid** | 五戒+价值光谱+必要场景+类型公约 | ★★★★☆ 分析框架强 |
| **Dan Harmon 故事圈** | 8步循环，强调对称性 | ★★★★☆ |
| **七点结构** | 7个关键情节点，非线性设计顺序 | ★★★★☆ |
| **Scene & Sequel** | 场景(目标→冲突→灾难) + 续篇(反应→困境→决定) | ★★★★★ 段落级别控制 |
| **起承转合** (东亚结构) | 不需要冲突，靠并置和转折 | ★★★☆☆ |

### 网文专有方法论

| 方法 | 说明 |
|------|------|
| **黄金三章** | 前三章决定生死：第1章建立金手指+冲突，第2章首次打脸，第3章升级+钩子 |
| **爽点设计** | 小爽(2-3千字一个)，中爽(每章)，大爽(3-5章)，超级爽(卷结尾) |
| **爽点类型** | 打脸、升级、获宝、揭秘、救人、逆转、认可、复仇 |
| **升级体系** | 7-12个大等级，每级3-9小阶段，每次突破需资源+试炼+顿悟 |
| **副本结构** | 入场→探索→小冲突→受挫→成长→高潮→过渡(标准10-20章弧线) |
| **伏笔管理** | 伏笔账本：埋设位置/类型/预期回收章节/实际解决/重要等级 |
| **章尾钩子** | 问题钩/揭示钩/危险钩/决定钩/到达钩/承诺钩/反转钩/情感钩/时限钩 |

---

## 六、去AI味 & 质量控制

### 8大去AI味技术（按效果排序）

| 排名 | 技术 | 效果 | 难度 | 说明 |
|------|------|------|------|------|
| 1 | 个人语料微调 | 非常高 | 中 | 收集5万+字自己的写作，用LoRA微调 |
| 2 | 风格迁移(Few-shot) | 非常高 | 低 | 提供5000-20000字目标风格作为参考 |
| 3 | 多轮生成+人工混合 | 非常高 | 高 | 多温度生成，选择性组合，人工写过渡 |
| 4 | 突发性工程 | 高 | 低 | 刻意变化句长：短句(3-5词)和长句(30+词)交替 |
| 5 | 困惑度注入 | 高 | 低 | 替换AI高频词，提高整体困惑度分数 |
| 6 | 语域混合 | 高 | 中 | 叙述中混合书面语和口语，方言和网络用语 |
| 7 | 结构不可预测性 | 中高 | 中 | 章节长度差异大，插入"跑题"段落 |
| 8 | 刻意不完美 | 中 | 低 | 偶尔重复、自我纠正、不规则标点 |

### AI常见"四件套"要避免

中文：然而 / 此外 / 值得注意的是 / 总的来说
英文：However / Furthermore / It's worth noting / In conclusion

### 中文网文平台检测现状

- **起点**：主动AI检测，以降推荐和下架为惩罚
- **番茄**：加强检测中，统计方法+读者举报
- **七猫**：日趋严格

**应对策略：**
1. 以人类速度上传(2000-4000字/天)
2. 保持独特角色声音
3. 避免"AI四件套"
4. 混入手写段落(尤其开头和关键场景)
5. 章节长度差异化(1500-4000字，不要均匀)

---

## 七、网文平台生态

### 平台对比

| 特征 | 起点 | 番茄 | 七猫 | 知乎盐选 | 晋江 |
|------|------|------|------|----------|------|
| 模式 | 付费 | 免费(广告) | 免费(广告) | 订阅制 | 付费 |
| 签约门槛 | 3-5万字 | 2万字 | 1-2万字 | 5千字 | 3万字 |
| 日更目标 | 4-6千 | 4-6千 | 4-6千 | 不适用(短篇) | 3-5千 |
| 全勤奖 | 600/月 | 600-1000/月 | 500-600/月 | 无 | 不定 |
| 读者层次 | 高 | 大众 | 大众 | 高学历 | 高 |
| 类型偏好 | 男频 | 男女皆有 | 男女皆有 | 文学/悬疑 | 女频 |
| IP价值 | 最高 | 增长中 | 中 | 中 | 高 |

### 热门题材 (2024-2025)

**男频热门：** 系统文、重生复仇、赘婿文、诡异复苏、无限流、直播文
**女频热门：** 穿越重生、团宠文、年代文、星际文、快穿

### AI写网文收入现实

- **新手：** 0-500 元/月（最常见真实报告）
- **成熟流水线：** 2000-8000 元/月
- **超过1万/月的声称大多未经验证，或来自卖课的人**

---

## 八、开源模型推荐

### 中文网文写作模型排名

| 排名 | 模型 | 优势 | 上下文 |
|------|------|------|--------|
| 1 | **Qwen2.5-72B** | 中文创意写作最佳开源模型 | 128K |
| 2 | **DeepSeek-V3** | 性价比最高，逻辑/情节强 | 128K |
| 3 | **Yi-34B/Yi-Large** | 同尺寸级别最好中文 | 200K |
| 4 | **GLM-4-Plus** | 文学中文强 | 128K |
| 5 | **Qwen3-30B-A3B** | 高效MoE，接近72B质量 | 128K |

### 社区创意写作微调模型（英文为主）

| 模型 | 基座 | 特点 |
|------|------|------|
| Sao10k/Euryale-v2.3 | Llama 3.1-70B | SillyTavern社区最赞 |
| anthracite-org/Magnum-v4-72B | Qwen2.5-72B | 中英文创意写作都强 |
| MN-Midnight-Miqu-70B | Mistral系 | 描写细腻，情感深度 |

### 微调建议

- **基座：** Qwen2.5-72B 或 Qwen2.5-32B（预算有限）
- **方法：** QLoRA (4bit量化 + LoRA)
- **数据：** 500-2000个高质量目标类型章节
- **格式：** (大纲+角色设定+前文摘要) → (正文章节) 的指令微调对
- **工具：** LLaMA-Factory / Axolotl

---

## 九、工作流自动化平台对比

| 平台 | 最适合 | 迭代支持 | 小说写作社区 | 开源 | 难度 |
|------|--------|---------|-------------|------|------|
| **Coze (扣子)** | 中国市场非技术用户 | Loop节点 | 非常大(星月工作流99万播放) | 否 | 低 |
| **Dify** | 技术用户要完全控制 | 原生(并行/串行) | 中等(增长中) | 是 | 中 |
| **n8n** | 开发者要灵活性 | SplitInBatches | 小 | 是 | 中高 |
| **FastGPT** | 知识库密集型写作 | 有限 | 小 | 是 | 中 |
| **Make.com** | 连接其他服务 | Iterator模块 | 无 | 否 | 低中 |

**Coze 热门小说写作工作流：**
- "星月写作工作流" - 99万+播放
- "月入两万deepseek写网文智能体" - 2.1万播放
- "扣子工作流搭建自动写小说" - 4.7万播放

**Dify 关键能力：** 迭代节点支持并行处理(最多10项同时)，非常适合批量章节生成。

---

## 十、学术论文关键成果

### 核心论文

| 论文 | 年份 | 核心创新 | 达到长度 |
|------|------|---------|---------|
| **Plan-and-Write** | 2019 | 规划与写作分离 | ~500词 |
| **PlotMachines** | 2020 | 动态情节状态追踪 | ~1000词 |
| **Re3** | 2022 | 递归重提示+修订 | 2000+词 |
| **DOC** | 2022 | 详细大纲控制，+22.5%连贯性 | 数千词 |
| **Dramatron** | 2022 | 分层提示链(前提→角色→节拍→场景→对话) | 完整剧本 |
| **RecurrentGPT** | 2023 | 语言级RNN记忆，理论无限长 | 任意长度 |
| **LongStory** | 2023 | 上下文权重校准+结构位置标记 | 可控长度 |
| **HoLLMwood** | 2024 | 多Agent角色扮演(编剧/编辑/演员) | 完整剧本 |
| **LongWriter** | 2024 | AgentWrite任务分解+专门SFT | 10000-20000+词 |

### 5种架构模式

1. **Plan-then-Write**: 先生成分层大纲，再逐段展开（最常见）
2. **Recursive/Iterative**: 逐块生成+记忆管理（RecurrentGPT）
3. **Multi-Agent**: 专门角色分工协作（HoLLMwood）
4. **Decomposition+Training**: 长生成任务分解+专门训练（LongWriter）
5. **Control+Revision**: 计划遵循检查+生成后修订（Re3, DOC）

---

## 十一、Claude Code Skill 架构

### 关键发现：目前已有少量小说写作 Skill，但没有成熟完整的

**这是一个空白机会。**

### Skill 技术规范

```yaml
# SKILL.md 前置数据
---
name: novel-writer
description: AI辅助长篇网络小说写作...
argument-hint: [command]
arguments: [command, target]
allowed-tools: Read Write Edit Bash(*) Agent
model: opus
effort: max
---
```

### 推荐目录结构

```
novel-writer/
├── SKILL.md              # 主指令文件 (<500行)
├── references/           # 参考文档（按需加载）
│   ├── style-guide.md
│   ├── plot-structures.md
│   ├── genre-templates/
│   └── anti-ai-rules.md
├── scripts/              # 可执行脚本
│   ├── consistency-check.py
│   ├── word-count.sh
│   └── export.py
├── assets/               # 模板和静态资源
│   ├── character-template.md
│   ├── outline-template.md
│   └── chapter-template.md
└── agents/               # 子Agent定义
    ├── researcher.md
    ├── writer.md
    ├── reviewer.md
    └── editor.md
```

### 多步骤工作流模式（参考 doc-coauthoring）

1. **阶段制工作流** - 定义3-5个明确阶段
2. **显式过渡点** - 阶段间需用户确认
3. **迭代精炼循环** - 草稿→审查→编辑→重复
4. **子Agent隔离** - `context: fork` 保持主上下文清洁
5. **文件制状态** - 用项目文件作为持久状态

---

## 十二、日韩市场 AI 写作工具

### 日本市场

| 工具 | 特点 |
|------|------|
| **AI Novelist (AIのべりすと)** | 2TB日文语料训练，Character Book标签激活系统，场景括号指令，格式密度控制(对话/省略号/括号密度)，最大192K字符上下文 |
| **NovelAI (Genji模型)** | 专门日语生成模型，双语BPE分词器，文风模仿，与图像生成联动 |
| **BunCho (文鳥)** | 专注前期规划(プロット生成)而非正文，移动端友好 |

### 韩国市场

- **Naver** (HyperCLOVA) 和 **Kakao** 的 AI 工具偏向内部/平台级，不对外开放
- 韩国市场更垂直整合（网文→漫画→电视剧），AI 工具服务于跨媒体 IP 流水线
- 对外定位"AI辅助"而非"AI生成"，规避读者反感

### 日韩特有的方法

| 方面 | 日韩做法 | 与中国/西方差异 |
|------|---------|----------------|
| 上下文窗口 | 极大(192K字符) | 西方靠摘要压缩 |
| 角色管理 | 标签激活(仅相关时注入) | 更高效，适合大量角色 |
| 场景控制 | 括号内联指令 `[场景描述]` | 更轻量的"导演笔记" |
| 风格粒度 | 标点密度/对话比例细粒度控制 | 日本轻小说子类型格式差异大 |
| 连载适配 | 为日更/周更设计 | 西方偏完整作品 |
| 同人支持 | 一等公民(续写模式/角色导入) | 西方通常边缘功能 |

---

## 十三、提示词工程核心技术

### 分层提示链架构

```
Chain 1: 前提 → 展开前提 (一句话→三段)
Chain 2: 前提 → 角色档案 (动机/内在冲突/说话模式)
Chain 3: 角色+前提 → 15节拍表 (Save the Cat)
Chain 4: 节拍 → 章节大纲 (每节拍2-3场景)
Chain 5: 大纲+Bible+摘要+前文 → 章节正文
```

### 每章上下文注入模板

```
=== 上下文 ===
[Story Bible 相关条目 ~500 tokens]

=== 前章摘要 ===
[200字摘要]

=== 本章大纲 ===
场景1: [视角] 在 [地点]。[角色] 发现 [事件]。情感弧: 好奇→恐惧
场景2: [视角] 对峙 [角色]。对话揭示 [秘密]。

=== 活跃线索 ===
- [本章需推进的线索]
- [需微妙推进的线索]

=== 风格约束 ===
- 视角: 第三人称限定, [角色名]
- 语调: [本章特定语调]
- 节奏: [慢热/快速/混合]

=== 硬约束 ===
- 字数: 3000-4000
- 必须包含: [具体情节点]
- 不得: 解决[线索X], 揭示[秘密Y]
- 结尾钩子: [具体钩子类型]
```

### AI禁用词表（中文版）

```
永远不要使用这些词/短语：
- "不禁"、"竟然"、"目光中闪过一丝..."
- "值得注意的是"、"总的来说"
- "如同XX一般"的过度比喻
- "时间仿佛停滞了"
- "心中涌起一股..."

避免这些模式：
- 连续段落以相同结构开头
- 三形容词列表 ("阴暗、冰冷、孤寂的夜晚")
- 展示情感后又解释情感
- 角色过度"点头"和"叹息"
```

### 多轮生成策略

```
Pass 1 - 骨架稿: 只关注发生了什么、谁说了什么(800字)
Pass 2 - 扩展: 加入感官细节、内心独白、肢体语言(3000字)
Pass 3 - 润色: 消除告诉式写作、强化对话潜台词、变化句式节奏
```

---

## 十四、整本书生成的现实评估

### 什么是可行的

- 一部可读的类型化小说，需要大量人工规划（总计40-60小时人工）
- 网文风格的连载，质量达到"对类型来说可接受"
- AI辅助写作（人写40%+AI写60%），日产6000-15000字

### 什么是不可行的

- 不经大量人工修订就能通过专业编辑审查的小说
- 有主题深度的复杂文学小说
- 细心读者感觉不到"AI味"的作品
- 出版质量的全自动生成

### 最佳实践比例

```
40% 规划 (大纲、角色、世界观、风格定义)
20% 生成 (AI写初稿)
40% 编辑/修订 (去AI味、一致性检查、风格调整)
```

### 最适合AI的类型

- ✅ 公式化/循环结构的网文（系统文、升级文、重生文）
- ✅ 快餐式娱乐（番茄/七猫类型）
- ✅ 非虚构（自助、教程、总结）
- ❌ 文学小说
- ❌ 推理/悬疑（需要严密线索布局）
- ❌ 复杂多视角叙事

---

## 十五、推荐的写作流水线设计

### 综合各方最佳实践的理想流水线

```
Phase 1: 立项与构思
  ├── 市场调研Agent → 分析热门题材、读者偏好、平台特征
  ├── 角色弧线Agent → 探索主角成长路径和关系
  ├── 叙事结构Agent → 探索多种叙事架构
  └── 主题Agent → 挖掘故事深层情感内核
  → 汇聚生成 3-5 个差异化方案，用户选择

Phase 2: 世界观 & 角色设计
  ├── 世界构建 (6大类系统化清单)
  ├── 角色卡片 (4层: 外在→社会→心理→哲学)
  ├── 力量体系设计
  └── → 生成 Story Bible v1

Phase 3: 大纲体系 (四级递进)
  ├── 总纲 (全书主线、核心冲突、结局)
  ├── 卷纲 (每卷目标、转折点)
  ├── 节纲 (每节情节推进、爽点分布)
  └── 章纲 (每章场景、冲突、钩子、字数目标)

Phase 4: 风格定义
  ├── 参考作品分析 → 提取写作特征 (20+维度)
  ├── 生成风格规范文档
  ├── 角色语音表 (每个角色的说话方式)
  └── AI味检测清单

Phase 5: 章节写作 (多Agent协作)
  ├── 上下文组装 (Story Bible + 章纲 + 前文摘要 + RAG检索)
  ├── Writer Agent → 写初稿
  ├── Style Reviewer → 检查AI味、风格一致性
  ├── Continuity Reviewer → 前后章衔接、伏笔、设定一致
  └── 闭环修改 → 不通过则反馈重写 (最多3轮)

Phase 6: 生成后处理
  ├── 事实提取 → 更新 Story Bible
  ├── 滚动摘要更新
  ├── 伏笔账本更新
  ├── 角色状态更新
  └── 字数/节奏验证

Phase 7: 全局审核 (定期)
  ├── 伏笔回收检查
  ├── 人物一致性审查
  ├── 情节弧线检查 (节奏、高潮分布)
  ├── 去AI味后处理
  └── 反向修改大纲 (发现更好走向时)

Phase 8: 输出
  ├── 多平台适配 (起点/番茄/知乎等格式差异)
  ├── 敏感词过滤
  └── 导出完整稿件
```

---

## 十六、下一步行动建议

### 方案A：基于现有项目二次开发

1. **Fork `claude-novel-writeFlow`** 作为 Claude Code Skill 的起点
2. 集成 **InkOS** 的 33 维审计系统和真相文件概念
3. 参考 **Lorn.NovelWriteSkills** 的资产库体系
4. 加入 **Morpheus** 的三层记忆架构

### 方案B：从零构建 Claude Code 写作 Skill

利用 Claude Code 的原生能力：
- **SKILL.md** 作为主指令
- **子Agent** (writer/reviewer/editor) 通过 `context: fork` 隔离
- **Hooks** 自动追踪字数、触发一致性检查
- **文件系统** 作为持久状态（大纲/角色/章节文件）
- **Plugin 打包** 分发给其他用户

### 方案C：混合方案

1. Claude Code Skill 负责交互入口和工作流编排
2. 本地 Qwen2.5-72B 负责大批量章节生成（降低成本）
3. Claude Opus 负责关键环节（审核、一致性检查、风格评估）
4. 向量数据库(ChromaDB)负责长期记忆

---

## 附录：数据源

### 搜索覆盖范围（22个方向）

1. GitHub 英文深度搜索 (10角度)
2. GitHub 中文深度搜索 (10角度)
3. Reddit / Hacker News 社区讨论
4. 学术论文 (arxiv)
5. 中文社区 (知乎/B站/CSDN)
6. 商业产品 & SaaS 工具 (15+产品)
7. 提示词工程 & 具体技巧
8. 写作方法论 & 故事结构 (16种方法)
9. 多Agent框架 (CrewAI/AutoGen等)
10. 记忆管理 & 一致性技术 (10种方案)
11. Claude Code Skill 结构研究
12. 网文平台 & 类型生态分析
13. 去AI味 & 质量评估技术 (8种方法)
14. YouTube / B站 视频教程
15. 开源模型 & 微调方案
16. Twitter/X / Discord 社区
17. Notion/Obsidian 写作工作流
18. 日韩轻小说/网文 AI工具
19. 提示词库 & 超级提示词
20. 工作流自动化 (Dify/Coze/n8n)
21. 整本书生成实验 & 案例
22. 微博/小红书/知乎 实战经验
