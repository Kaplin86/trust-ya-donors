extends TextureRect

var baseOffset : Vector2

func _ready():
	baseOffset = position

var dt = 0.0
func _process(delta):
	dt += delta
	offset_transform_position = baseOffset + (Vector2(sin(dt)*1.2,cos(dt*2)))
