extends BaseRelic
class_name RetexturingRelic

@export var mesh : MeshInstance3D

func _ready():
	var newMat = StandardMaterial3D.new()
	if fake:
		var texture = null
		var possibleNumbers = [0,1,2,3,4,5,6,7,8,9,10]
		while texture == null:
			var test = possibleNumbers.pick_random()
			possibleNumbers.erase(test)
			texture = load("res://relics/"+relic+"/fake"+str(test)+ ".png")
		newMat.albedo_texture = texture
	else:
		newMat.albedo_texture = load("res://relics/"+relic+"/real.png")
	mesh.set_surface_override_material(0,newMat)
