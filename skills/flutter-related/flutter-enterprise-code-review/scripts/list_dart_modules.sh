#!/usr/bin/env bash
# 列出 lib/ 下一级目录作为「候选模块」，供制定评审计划时使用。
# 用法（在 Flutter 项目根目录执行）：
#   bash scripts/list_dart_modules.sh
#   bash path/to/skill/scripts/list_dart_modules.sh
# 或指定 lib 路径：
#   bash scripts/list_dart_modules.sh /path/to/project/lib

set -e
LIB_DIR="${1:-lib}"
if [[ ! -d "$LIB_DIR" ]]; then
  echo "Error: $LIB_DIR not found. Run from project root or pass lib path." >&2
  exit 1
fi
echo "# Candidate modules (top-level under $LIB_DIR)"
find "$LIB_DIR" -maxdepth 1 -type d ! -path "$LIB_DIR" | sed "s|^$LIB_DIR/||" | sort
