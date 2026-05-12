#!/bin/bash
# 字数统计脚本
# 用法: bash word-count.sh [目录路径]
# 示例: bash word-count.sh "04-正文/"
#       bash word-count.sh "04-正文/卷01/"

TARGET="${1:-.}"

echo "=== ai-story 字数统计 ==="
echo ""

TOTAL=0

# 扫描所有 .md 文件
while IFS= read -r -d '' file; do
    # 统计中文字符数（去掉标点、空格、Markdown标记）
    chars=$(sed 's/#//g; s/\*//g; s/\[//g; s/\]//g; s/(//g; s/)//g' "$file" | tr -d '[:space:][:punct:]' | wc -m)
    if [ "$chars" -gt 0 ]; then
        basename=$(basename "$file")
        dirname=$(dirname "$file" | sed "s|^$TARGET/\?||")
        if [ -n "$dirname" ]; then
            echo "  ${dirname}/${basename}: ${chars} 字"
        else
            echo "  ${basename}: ${chars} 字"
        fi
        TOTAL=$((TOTAL + chars))
    fi
done < <(find "$TARGET" -name "*.md" -type f -print0 | sort -z)

echo ""
echo "  总计: ${TOTAL} 字"

# 番茄日更参考
if [ "$TOTAL" -gt 0 ]; then
    DAYS=$((TOTAL / 4000))
    echo "  约等于 ${DAYS} 天日更量（按4000字/天计算）"
fi
