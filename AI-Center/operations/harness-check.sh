#!/bin/bash
# harness-check.sh
# 扫描所有 Harness 卡，计算合规度，输出报告
# v0.1 - 2026-06-27

AGENTS_DIR="$HOME/PersonalKnowledge/AI-Center/agents"
PROJECTS_DIR="$HOME/PersonalKnowledge/AI-Center/projects"

echo "=== Harness 合规度检查报告 ==="
echo "检查时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 检查 Agent 卡
echo "--- Agent Harness 卡 ---"
if [ -d "$AGENTS_DIR" ]; then
    for card in "$AGENTS_DIR"/*.md; do
        [ -f "$card" ] || continue
        name=$(basename "$card" .md)
        # 数 ✅ 出现次数
        score=$(grep -c "✅" "$card" 2>/dev/null || echo 0)
        # ⚠️ 计 0.5 分
        warn=$(grep -c "⚠️" "$card" 2>/dev/null || echo 0)
        # 计算加权分（保留一位小数）
        total=$(echo "scale=1; $score + $warn * 0.5" | bc 2>/dev/null || echo "$score")
        echo "[$total/8] $name"
    done
else
    echo "  (agents 目录不存在：$AGENTS_DIR)"
fi

echo ""
echo "--- 场景 Harness 卡 ---"
if [ -d "$PROJECTS_DIR" ]; then
    found=0
    for card in "$PROJECTS_DIR"/*/harness-card.md; do
        [ -f "$card" ] || continue
        found=1
        name=$(basename "$(dirname "$card")")
        score=$(grep -c "✅" "$card" 2>/dev/null || echo 0)
        warn=$(grep -c "⚠️" "$card" 2>/dev/null || echo 0)
        total=$(echo "scale=1; $score + $warn * 0.5" | bc 2>/dev/null || echo "$score")
        echo "[$total/8] $name"
    done
    if [ $found -eq 0 ]; then
        echo "  (暂无场景 Harness 卡)"
    fi
else
    echo "  (projects 目录不存在：$PROJECTS_DIR)"
fi

echo ""
echo "--- 提醒 ---"
echo "合规度 < 4/8：禁止上线"
echo "合规度 4-5/8：可小范围试点"
echo "合规度 6/8：可灰度上线"
echo "合规度 7-8/8：可正式上线"