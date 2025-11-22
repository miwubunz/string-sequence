@tool
extends EditorPlugin

const SEQ = "StringSequence"

func _enable_plugin() -> void:
	add_custom_type(SEQ, "Node", preload("StringSequence.gd"), preload("icon.svg"))


func _disable_plugin() -> void:
	remove_custom_type(SEQ)