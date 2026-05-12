#!/bin/bash
# post-compact hook: 上下文压缩后提示恢复

STORY_STATE=".story-state"
SNAPSHOT=".story-snapshot.json"

if [ ! -f "$STORY_STATE" ]; then
  exit 0
fi

BOOK_NAME=$(grep -o '"book_name"[[:space:]]*:[[:space:]]*"[^"]*"' "$STORY_STATE" | sed 's/.*: *"\(.*\)"/\1/')
CURRENT_VOL=$(grep -o '"current_volume"[[:space:]]*:[[:space:]]*[0-9]*' "$STORY_STATE" | sed 's/.*: *//')
CURRENT_CH=$(grep -o '"current_chapter"[[:space:]]*:[[:space:]]*[0-9]*' "$STORY_STATE" | sed 's/.*: *//')

echo "ai-story: ⚠️ 上下文已压缩。"
echo "  项目：《${BOOK_NAME}》第${CURRENT_VOL}卷 第${CURRENT_CH}章"
echo "  请读取 .story-state 和 03-追踪/ 恢复完整上下文后再继续写作。"

# 检查脏状态
WIP=$(grep -o '"writing_in_progress"' "$STORY_STATE" 2>/dev/null)
if [ -n "$WIP" ]; then
  echo "  ⚠️ 检测到未完成的写作任务，说\"继续\"恢复。"
fi
