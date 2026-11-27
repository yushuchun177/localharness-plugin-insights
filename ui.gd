extends VBoxContainer
## 上下文洞察 —— 这个页面是插件自己提供的界面。
## 界面全部由插件自己拼，主程序只提供积木。

func build(plugin_id: String) -> void:
	add_theme_constant_override("separation", 12)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL

	add_child(PluginUI.section("当前对话"))
	add_child(PluginUI.action_row("看一下这个对话有多大",
		"消息条数、字数、估算 token、还剩多少上下文", "统计",
		func(): return Plugins.invoke("context_stats", {})))
	add_child(PluginUI.action_row("整理早期对话", "把较早的内容列出来，只读不改", "读取",
		func(): return Plugins.invoke("context_digest", {"keep": 4})))
	add_child(PluginUI.overview(plugin_id))
	add_child(PluginUI.permissions_section(plugin_id))
	add_child(PluginUI.doc_section(plugin_id))
