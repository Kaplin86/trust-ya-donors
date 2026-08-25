extends StaticBody3D
class_name RelicDisplayPedestal

@export var type : String
@export var fake := false

@export var relicBottom : Node3D

var currentRelic = null

func _update():
	if currentRelic:
		currentRelic.queue_free()
	var model : BaseRelic = load("res://relics/"+type+"/main.tscn").instantiate()
	model.fake = fake
	add_child(model)
	currentRelic = model
	var box = model.get_aabb().size
	model.global_position = relicBottom.global_position
	model.global_basis = relicBottom.global_basis
	model.global_position.y += box.y * 0.5

func _ready():
	_update()
