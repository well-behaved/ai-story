#!/bin/bash
# pre-compact hook: 上下文压缩前保存快照

STORY_STATE=".story-state"
SNAPSHOT=".story-snapshot.json"

if [ ! -f "$STORY_STATE" ]; then
  exit 0
fi

# 复制当前状态为快照
cp "$STORY_STATE" "$SNAPSHOT"

echo "ai-story: 快照已保存到 .story-snapshot.json"
