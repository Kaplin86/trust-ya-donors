extends Control

var TOOLTIP = preload("res://scenes/tooltip.tscn")

func _make_custom_tooltip(for_text):
	var tooltip_instance = TOOLTIP.instantiate()
	tooltip_instance.set_text(for_text)
	return tooltip_instance
	
