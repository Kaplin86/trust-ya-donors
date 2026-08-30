extends StaticBody3D
class_name Button3D

signal pressed

@export var sound : AudioStreamPlayer

func press():
	pressed.emit()
	sound.play()
