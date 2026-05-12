#!/usr/bin/env python3
"""
番茄小说敏感词检查脚本
用法: python sensitive-check.py <文件路径或目录>
示例: python sensitive-check.py "04-正文/卷01/第001章.md"
      python sensitive-check.py "04-正文/卷01/"  (扫描整个目录)
"""

import sys
import os
import re

# 敏感词库（按类别组织）
SENSITIVE_WORDS = {
    "政治敏感": [
        "政变", "起义", "革命", "暴动", "游行", "示威", "罢工",
        "独裁", "专制", "腐败", "贪官", "维权", "上访",
        "共产", "国民党", "文革", "六四", "天安门",
    ],
    "色情相关": [
        "做爱", "性爱", "裸体", "乳房", "阴茎", "阴道",
        "高潮", "呻吟", "抽插", "口交", "肉体", "淫荡",
        "勾引", "调情", "春宵", "云雨", "巫山",
    ],
    "暴力过度": [
        "虐杀", "分尸", "肢解", "挖眼", "剥皮", "活埋",
        "酷刑", "凌迟", "腰斩", "砍头", "绞刑",
    ],
    "封建迷信": [
        "鬼魂", "鬼怪", "招魂", "通灵", "附身",
        "算命", "占卜", "风水", "看相", "驱鬼",
    ],
    "毒品赌博": [
        "大麻", "可卡因", "海洛因", "冰毒", "摇头丸",
        "吸毒", "贩毒", "赌博", "赌场", "老虎机",
    ],
    "未成年相关": [
        "恋童", "未成年", "小学生", "初中生",
    ],
}

# 可替换建议
REPLACE_SUGGESTIONS = {
    "鬼魂": "诡异存在/异类",
    "鬼怪": "诡异/异象",
    "招魂": "召唤术",
    "算命": "推演",
    "占卜": "卜算/推演",
    "风水": "气运/地脉",
    "做爱": "双修/合体",
    "裸体": "衣衫不整",
    "高潮": "巅峰/极致(非色情语境可用)",
}


def scan_file(filepath):
    """扫描单个文件中的敏感词"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"  ❌ 无法读取 {filepath}: {e}")
        return []

    lines = content.split('\n')
    findings = []

    for category, words in SENSITIVE_WORDS.items():
        for word in words:
            for i, line in enumerate(lines, 1):
                if word in line:
                    suggestion = REPLACE_SUGGESTIONS.get(word, "建议删除或改写")
                    findings.append({
                        'file': filepath,
                        'line': i,
                        'category': category,
                        'word': word,
                        'context': line.strip()[:60],
                        'suggestion': suggestion,
                    })

    return findings


def scan_directory(dirpath):
    """扫描目录下所有 .md 文件"""
    all_findings = []
    for root, dirs, files in os.walk(dirpath):
        for f in sorted(files):
            if f.endswith('.md'):
                filepath = os.path.join(root, f)
                findings = scan_file(filepath)
                all_findings.extend(findings)
    return all_findings


def main():
    if len(sys.argv) < 2:
        print("用法: python sensitive-check.py <文件路径或目录>")
        print("示例: python sensitive-check.py \"04-正文/卷01/第001章.md\"")
        sys.exit(1)

    target = sys.argv[1]

    if os.path.isfile(target):
        findings = scan_file(target)
    elif os.path.isdir(target):
        findings = scan_directory(target)
    else:
        print(f"❌ 路径不存在: {target}")
        sys.exit(1)

    if not findings:
        print("✅ 未发现敏感词")
        sys.exit(0)

    # 按类别分组输出
    print(f"\n⚠️ 发现 {len(findings)} 处敏感词\n")

    categories = {}
    for f in findings:
        cat = f['category']
        if cat not in categories:
            categories[cat] = []
        categories[cat].append(f)

    for cat, items in categories.items():
        print(f"【{cat}】{len(items)} 处")
        for item in items:
            fname = os.path.basename(item['file'])
            print(f"  第{item['line']}行 \"{item['word']}\" → {item['suggestion']}")
            print(f"    上下文: {item['context']}")
        print()

    # 输出汇总
    print("---")
    print(f"总计: {len(findings)} 处敏感词，涉及 {len(categories)} 个类别")
    print("建议: 修改后重新运行本脚本验证")


if __name__ == '__main__':
    main()
