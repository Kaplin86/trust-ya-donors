extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GlobalStuff.runsCurrentRelics = []

func _on_lofi_pressed():
	GlobalStuff.tutorial = false
	GlobalStuff.allowDuplicate = false
	GlobalStuff.timer = false
	Transition.to_scene("res://scenes/main.tscn")


func _on_tutorial_pressed():
	GlobalStuff.tutorial = true
	GlobalStuff.allowDuplicate = true
	GlobalStuff.timer = false
	Transition.to_scene("res://scenes/main.tscn")


func _on_timer_pressed():
	GlobalStuff.tutorial = false
	GlobalStuff.allowDuplicate = true
	GlobalStuff.timer = true
	Transition.to_scene("res://scenes/main.tscn")
