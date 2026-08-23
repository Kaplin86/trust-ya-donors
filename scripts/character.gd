extends CharacterBody3D

const SPEED = 10.0
var mouse_sensitivity = 0.002

var twist_input = 0.0
var pitch_input = 0.0

var hover

var rotatingRelic = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if rotatingRelic:
		hover.rotate_y(twist_input)
		hover.rotate_x(pitch_input)
		twist_input = 0
		pitch_input = 0
	else:
		rotate_y(twist_input)
		$Camera3D.rotate_x(pitch_input)
		$Camera3D.rotation_degrees.x = clamp($Camera3D.rotation_degrees.x,-80,80)
		twist_input = 0
		pitch_input = 0
	
	if Input.is_action_just_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var target = $Camera3D/RayCast3D.get_collider() 
	if target == null or target != hover:
		if hover:
			hover.find_child("outline").visible = false
	if target is BaseRelic:
		if hover != target and hover:
			hover.find_child("outline").visible = false
		if target:
			hover = target
			hover.find_child("outline").visible = true

	if hover and hover is BaseRelic and hover.rotatable:
		if rotatingRelic == false:
			if Input.is_action_just_pressed("use"):
				rotatingRelic = true
				
		else:
			if Input.is_action_just_pressed("use"):
				rotatingRelic = false

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	if input_dir != Vector2.ZERO:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
