# 上下文洞察 / Context insights

看一眼当前对话有多大：消息数、字数、估算 token、还能塞多少；以及把早期历史压成摘要。

Inspect the current conversation size (messages, chars, estimated tokens, headroom) and compress early history into a summary.

> Local-Harness（Godot 版）的独立插件。不随主程序发布，由主程序
> 「设置 → 插件管理」从 GitHub 下载并自动部署到 `user://plugins/insights/`。

## 安装

1. 打开 Local-Harness → 设置 → 插件管理 → 刷新列表
2. 找到「上下文洞察」点「安装」
3. 装好后在侧栏底部点同名按钮，里面是这个插件自己的设置页

手动安装：把本仓库下载解压到 `%LOCALAPPDATA%\Godot\app_userdata\Local-Harness\plugins\insights\`

## 工具

- `context_stats` —— 返回当前会话的统计：消息数、总字数、估算 token 数、上下文余量。（只读）
- `context_digest` —— 把最近 N 轮之前的对话压成一段摘要文本（不直接改历史，只返回摘要）。（只读）
  - `keep`: int，可选，保留最近几轮，默认 4

## 命令

（没有命令）

## 设置项

（没有可调参数）

## 权限

每个工具都能在插件设置页里单独开关。关掉之后它不会出现在模型的工具清单里，
就算模型硬要调用也会被主程序拒绝。协议里用 `level` 标了风险等级：

- `read` 只读：不会改动任何东西
- `act` 会产生操作：会读写文件、联网或占用设备
- `danger` 高危：会操作你的系统

## 怎么用

装好后直接在对话里提需求，例如：“返回当前会话的统计：消息数、总字数、估算 token 数、上下文余量。”

模型会输出一行 ```tool 协议块，宿主解析后执行，再把结果喂回模型。
也可以直接用斜杠命令，不经过模型。

## 许可

GPL-3.0（与主程序一致）。完整协议文本见仓库根目录的 [LICENSE](LICENSE)。

---

# Context insights

Inspect the current conversation size (messages, chars, estimated tokens, headroom) and compress early history into a summary.

> An independent plugin for **Local-Harness (Godot edition)**. It is not bundled with the
> app; the app downloads it from this repository into `user://plugins/insights/` and hot-loads it.

## Install

1. Local-Harness → Settings → Plugins → Refresh
2. Find "Context insights" and click Install
3. Open it from the button at the bottom of the sidebar for its own settings page

Manual: unzip this repo into `%LOCALAPPDATA%\Godot\app_userdata\Local-Harness\plugins\insights\`

## Tools

- `context_stats` — 返回当前会话的统计：消息数、总字数、估算 token 数、上下文余量。 (read-only)
- `context_digest` — 把最近 N 轮之前的对话压成一段摘要文本（不直接改历史，只返回摘要）。 (read-only)
  - `keep`: int，可选，保留最近几轮，默认 4

## Commands

(no commands)

## Settings

(nothing to configure)

## Permissions

Every tool can be toggled individually on the plugin settings page. A disabled tool is
removed from the model's tool list and rejected by the host even if the model still calls it.
`level` in the manifest marks the risk:

- `read` — no side effects
- `act` — reads/writes, network or devices
- `danger` — controls your system

## Usage

Just ask in the chat, e.g. “返回当前会话的统计：消息数、总字数、估算 token 数、上下文余量。”

The model emits a ```tool block, the host executes it and feeds the result back.
You can also use the slash commands above, which skip the model entirely.

## License

GPL-3.0 (same as the host app). Full text: [LICENSE](LICENSE).
