extends Node3D

func _ready():
	var museum = load("res://scenes/museum.tscn")
	add_child(museum.instantiate())
