extends BaseRelic
class_name RetexturingRelic

@export var mesh : MeshInstance3D


func _ready():
	var newMat : StandardMaterial3D = mesh.mesh.get("surface_0/material")
	newMat.resource_local_to_scene = true
	newMat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR
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
	#mesh.set_surface_override_material(0,newMat)

func get_aabb():
	return mesh.get_aabb()
