extends VBoxContainer
## 本插件的设置界面 —— 由插件自己提供，主程序只负责挂载。
## 想改这个插件在这里长什么样、有哪些开关，改这个文件即可。

func build(plugin_id: String) -> void:
	add_theme_constant_override("separation", 10)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(PluginUI.title("上下文洞察"))
	add_child(PluginUI.hint("只看不改：告诉你这个会话有多大、还剩多少上下文、早期聊了什么。"))
	add_child(PluginUI.section("能力开关"))
	add_child(PluginUI.hint("每一项都能单独关掉；关掉后模型看不到这个能力，也调用不了。"))
	for t in Plugins.tools_of(plugin_id):
		var tname := str(t.get("name", ""))
		var human := tname
		var desc := str(t.get("description", ""))
		if tname == "context_stats":
			human = "查看会话统计"
			desc = "消息数、字数、估算 token"
		if tname == "context_digest":
			human = "读取早期对话"
			desc = "把较早的内容整理出来，只读"
		add_child(PluginUI.perm_row(tname, human, desc, bool(t.get("dangerous", false))))
	add_child(PluginUI.readme_box(plugin_id))
