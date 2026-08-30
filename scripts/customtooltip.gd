extends Control

var TOOLTIP = preload("res://scenes/tooltip.tscn")
var sound = preload("res://audio/sfx/niceclick.wav")

func _make_custom_tooltip(for_text):
	var tooltip_instance = TOOLTIP.instantiate()
	tooltip_instance.set_text(for_text)
	return tooltip_instance
	

func _process(delta):
	offset_transform_enabled = true
	offset_transform_scale = lerp(offset_transform_scale,Vector2.ONE,delta * 9)

func _on_mouse_entered():
	var newStream = AudioStreamPlayer.new()
	add_child(newStream)
	newStream.stream = sound
	newStream.play()
	offset_transform_scale = Vector2.ONE * 1.2
