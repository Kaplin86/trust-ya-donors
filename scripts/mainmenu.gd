extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GlobalStuff.runsCurrentRelics = []
	GlobalStuff.Day = 0

func _on_lofi_pressed():
	GlobalStuff.tutorial = false
	GlobalStuff.allowDuplicate = false
	GlobalStuff.timer = false
	GlobalStuff.metaMuseum = false
	Transition.to_scene("res://scenes/main.tscn")


func _on_tutorial_pressed():
	GlobalStuff.tutorial = true
	GlobalStuff.allowDuplicate = true
	GlobalStuff.timer = false
	GlobalStuff.metaMuseum = false
	Transition.to_scene("res://scenes/main.tscn")


func _on_timer_pressed():
	GlobalStuff.tutorial = false
	GlobalStuff.allowDuplicate = true
	GlobalStuff.timer = true
	GlobalStuff.metaMuseum = false
	Transition.to_scene("res://scenes/main.tscn")


func _on_meta_pressed():
	GlobalStuff.tutorial = false
	GlobalStuff.allowDuplicate = false
	GlobalStuff.timer = false
	GlobalStuff.metaMuseum = true
	Transition.to_scene("res://scenes/main.tscn")
