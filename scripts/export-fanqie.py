#!/usr/bin/env python3
"""
番茄小说格式导出脚本
将正文目录中的所有章节合并为一个 TXT 文件，符合番茄小说平台的上传格式。

用法: python export-fanqie.py <正文目录> [输出文件名]
示例: python export-fanqie.py "04-正文/" "我的小说.txt"
      python export-fanqie.py "04-正文/卷01/"
"""

import sys
import os
import re


def extract_chapter_number(filename):
    """从文件名提取章节号用于排序"""
    match = re.search(r'第(\d+)章', filename)
    if match:
        return int(match.group(1))
    return 0


def clean_markdown(content):
    """清理 Markdown 格式，转为纯文本"""
    lines = content.split('\n')
    result = []

    for line in lines:
        # 一级标题转为章节标题格式
        if line.startswith('# '):
            result.append(line[2:].strip())
            result.append('')
            continue

        # 去掉其他级别标题的 # 号
        if re.match(r'^#{2,6}\s', line):
            result.append(line.lstrip('#').strip())
            continue

        # 去掉加粗/斜体标记
        line = re.sub(r'\*\*(.+?)\*\*', r'\1', line)
        line = re.sub(r'\*(.+?)\*', r'\1', line)

        # 去掉其他 Markdown 标记
        line = re.sub(r'`(.+?)`', r'\1', line)
        line = re.sub(r'\[(.+?)\]\(.+?\)', r'\1', line)

        result.append(line)

    return '\n'.join(result)


def main():
    if len(sys.argv) < 2:
        print("用法: python export-fanqie.py <正文目录> [输出文件名]")
        sys.exit(1)

    source_dir = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else "导出-番茄.txt"

    if not os.path.isdir(source_dir):
        print(f"❌ 目录不存在: {source_dir}")
        sys.exit(1)

    # 收集所有章节文件（支持分卷目录）
    chapters = []
    for root, dirs, files in os.walk(source_dir):
        dirs.sort()  # 确保卷目录按顺序
        for f in files:
            if f.endswith('.md') and '第' in f and '章' in f:
                filepath = os.path.join(root, f)
                # 提取卷号用于全局排序
                vol_match = re.search(r'卷(\d+)', root)
                vol_num = int(vol_match.group(1)) if vol_match else 0
                ch_num = extract_chapter_number(f)
                global_order = vol_num * 10000 + ch_num
                chapters.append((global_order, filepath, f))

    chapters.sort(key=lambda x: x[0])

    if not chapters:
        print(f"❌ 未找到章节文件: {source_dir}")
        sys.exit(1)

    # 合并导出
    total_chars = 0
    with open(output_file, 'w', encoding='utf-8') as out:
        for i, (order, filepath, filename) in enumerate(chapters):
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            clean = clean_markdown(content)
            char_count = len(clean.replace('\n', '').replace(' ', ''))
            total_chars += char_count

            if i > 0:
                out.write('\n\n')

            out.write(clean)

            print(f"  {filename}: {char_count} 字")

    print(f"\n✅ 导出完成: {output_file}")
    print(f"  章节数: {len(chapters)}")
    print(f"  总字数: {total_chars}")
    print(f"  文件大小: {os.path.getsize(output_file) / 1024:.1f} KB")


if __name__ == '__main__':
    main()
