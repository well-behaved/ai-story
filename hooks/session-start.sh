#!/bin/bash
# session-start hook: 会话启动时读取项目状态并输出进度提示

STORY_STATE=".story-state"

if [ ! -f "$STORY_STATE" ]; then
  echo "ai-story: 未检测到小说项目。说\"帮我开一本小说\"开始创作。"
  exit 0
fi

# 读取 JSON 字段（兼容无 jq 的环境用 grep+sed）
BOOK_NAME=$(grep -o '"book_name"[[:space:]]*:[[:space:]]*"[^"]*"' "$STORY_STATE" | sed 's/.*: *"\(.*\)"/\1/')
CURRENT_VOL=$(grep -o '"current_volume"[[:space:]]*:[[:space:]]*[0-9]*' "$STORY_STATE" | sed 's/.*: *//')
CURRENT_CH=$(grep -o '"current_chapter"[[:space:]]*:[[:space:]]*[0-9]*' "$STORY_STATE" | sed 's/.*: *//')
TOTAL_WORDS=$(grep -o '"total_words"[[:space:]]*:[[:space:]]*[0-9]*' "$STORY_STATE" | sed 's/.*: *//')
STATUS=$(grep -o '"status"[[:space:]]*:[[:space:]]*"[^"]*"' "$STORY_STATE" | sed 's/.*: *"\(.*\)"/\1/')

NEXT_CH=$((CURRENT_CH + 1))

# 检查脏状态（上次写作是否被中断）
WIP_CH=$(grep -o '"writing_in_progress"' "$STORY_STATE" 2>/dev/null)

echo "ai-story: 《${BOOK_NAME}》第${CURRENT_VOL}卷 第${CURRENT_CH}章 共${TOTAL_WORDS}字 [${STATUS}]"

if [ -n "$WIP_CH" ]; then
  WIP_CHAPTER=$(grep -o '"chapter"[[:space:]]*:[[:space:]]*[0-9]*' "$STORY_STATE" | tail -1 | sed 's/.*: *//')
  WIP_STAGE=$(grep -o '"stage"[[:space:]]*:[[:space:]]*"[^"]*"' "$STORY_STATE" | tail -1 | sed 's/.*: *"\(.*\)"/\1/')
  echo "  ⚠️ 上次写第${WIP_CHAPTER}章在${WIP_STAGE}阶段被中断，说\"继续\"恢复"
elif [ "$STATUS" = "initialized" ]; then
  echo "  → 下一步：说\"写大纲\"生成章纲"
elif [ "$CURRENT_CH" -eq 0 ]; then
  echo "  → 下一步：说\"写第一章\"开始创作"
else
  echo "  → 下一步：说\"日更\"写第${NEXT_CH}章"
fi
