extends Node2D

func _ready():
	if !OS.has_feature("web"):
		get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")




func _on_pass_pressed():
	GlobalStuff.doesMuseumExist = false
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")


func _on_keep_pressed():
	GlobalStuff.doesMuseumExist = true
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
