extends Node3D

func _ready():
	if GlobalStuff.doesMuseumExist:
		var museum = load("res://scenes/museum.tscn")
		add_child(museum.instantiate())
