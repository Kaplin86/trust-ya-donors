extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GlobalStuff.runsCurrentRelics = []

func _on_lofi_pressed():
	GlobalStuff.tutorial = false
	GlobalStuff.allowDuplicate = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_tutorial_pressed():
	GlobalStuff.tutorial = true
	GlobalStuff.allowDuplicate = true
	get_tree().change_scene_to_file("res://scenes/main.tscn")
