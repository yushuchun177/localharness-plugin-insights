extends Node
## 上下文洞察插件 · local-harness
## 工具：context_stats / context_digest
##
## 直接读 App 单例里的当前会话（插件就挂在 autoload 下面，能拿到 App）。


func run(tool: String, args: Dictionary) -> Dictionary:
	match tool:
		"context_stats":
			return _stats()
		"context_digest":
			return _digest(args)
	return {"ok": false, "output": "未知工具：%s" % tool}


func _chat() -> Dictionary:
	if App == null or App.chats.is_empty() or App.current_chat < 0:
		return {}
	return App.chats[App.current_chat]


func _est_tokens(text: String) -> int:
	# 中英混排的粗估：CJK 约 1.5 字/token，其余约 4 字符/token
	var cjk := 0
	for i in text.length():
		var c := text.unicode_at(i)
		if c >= 0x2E80 and c <= 0x9FFF:
			cjk += 1
	var other := text.length() - cjk
	return int(cjk / 1.5) + int(other / 4.0) + 1


func _stats() -> Dictionary:
	var chat := _chat()
	if chat.is_empty():
		return {"ok": false, "output": "还没有对话"}
	var msgs: Array = chat.get("messages", [])
	var chars := 0
	for m in msgs:
		chars += str(m.get("content", "")).length()
	var ctx := int(App.cfg.get("ctx", 4096))
	var used := _est_tokens("".join(msgs.map(func(m): return str(m.get("content", "")))))
	var pct := 0.0 if ctx <= 0 else float(used) / float(ctx) * 100.0
	return {"ok": true, "output": "消息 %d 条 · 字数 %d · 估算 %d tokens · 上下文 %d（占 %.1f%%）· 余量约 %d tokens" % [
		msgs.size(), chars, used, ctx, pct, max(0, ctx - used)]}


func _digest(args: Dictionary) -> Dictionary:
	var chat := _chat()
	if chat.is_empty():
		return {"ok": false, "output": "还没有对话"}
	var keep := int(args.get("keep", 4))
	var msgs: Array = chat.get("messages", [])
	var cut := max(0, msgs.size() - keep * 2)
	if cut <= 0:
		return {"ok": true, "output": "对话还不够长，不用压缩"}
	var head: Array = msgs.slice(0, cut)
	var lines: PackedStringArray = []
	for m in head:
		var role := "用户" if str(m.get("role", "")) == "user" else "助手"
		var t := str(m.get("content", ""))
		if t.length() > 120:
			t = t.substr(0, 120) + "…"
		lines.append("%s：%s" % [role, t])
	return {"ok": true, "output": "早期 %d 条消息（可用来做摘要）：\n%s" % [head.size(), "\n".join(lines)]}
