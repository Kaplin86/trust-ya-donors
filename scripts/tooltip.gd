extends Control

@export var label : RichTextLabel

func set_text(text : String) -> void:
	#visible = false
	label.text = text

func _process(delta):
	get_parent().position.x = 430
	#visible = true
