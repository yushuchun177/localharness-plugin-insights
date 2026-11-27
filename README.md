# 上下文洞察 / Context insights

看一眼当前对话有多大：消息数、字数、估算 token、还能塞多少；以及把早期历史压成摘要。

Inspect the current conversation size (messages, chars, estimated tokens, headroom) and compress early history into a summary.

Local-Harness（Godot 版）的独立插件。**不随主程序发布**，由主程序「设置 → 插件管理」从 GitHub 下载并自动部署到 `user://plugins/insights/`。

## 工具

- `context_stats` —— 返回当前会话的统计：消息数、总字数、估算 token 数、上下文余量。
- `context_digest` —— 把最近 N 轮之前的对话压成一段摘要文本（不直接改历史，只返回摘要）。
  - `keep`: int，可选，保留最近几轮，默认 4

## 安装

1. Local-Harness → 设置 → 插件管理 → 刷新列表
2. 找到「上下文洞察」点安装
3. 装完直接在对话里让模型调用（插件会出现在系统提示的工具清单里）

手动安装：把仓库解压到 `%LOCALAPPDATA%\Godot\app_userdata\Local-Harness\plugins\insights\`。

## 结构

```
manifest.json   清单：id / 版本 / 工具定义
main.gd         extends Node，实现 run(tool, args) -> {ok, output}
```

## 许可

GPL-3.0（与主程序一致）。完整协议文本见仓库根目录的 `LICENSE` 文件。
