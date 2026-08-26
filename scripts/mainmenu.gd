extends Control

func _ready():
	GlobalStuff.runsCurrentRelics = []

func _on_lofi_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
