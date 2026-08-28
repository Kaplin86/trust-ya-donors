extends CharacterBody3D
class_name Character

const SPEED = 10.0
var mouse_sensitivity = 0.002

var twist_input = 0.0
var pitch_input = 0.0

var hover

var rotatingRelic = false
var readingBook = false

signal readBook(type : String)
signal closeBook()

@export var displayText : Label

signal Movement
signal Mousement

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if rotatingRelic:
		hover.rotate_y(twist_input)
		hover.rotate_x(pitch_input)
		twist_input = 0
		pitch_input = 0
		
		
		
	elif !readingBook:
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
	displayText.text = ""
	if target is BaseRelic or target is Book or target is Button3D:
		if hover != target and hover:
			hover.find_child("outline").visible = false
		if target:
			hover = target
			hover.find_child("outline").visible = true
		
		if hover:
			displayText.text = ""
			if target is BaseRelic:
				displayText.text = target.relic.capitalize()
				if rotatingRelic == false:
					if Input.is_action_just_pressed("use"):
						rotatingRelic = true
						
				else:
					if Input.is_action_just_pressed("use"):
						rotatingRelic = false
			elif target is Book:
				displayText.text = target.bookname.capitalize()
				if readingBook == false:
					if Input.is_action_just_pressed("use"):
						readingBook = true
						readBook.emit(target.bookname)
						Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				else:
					if Input.is_action_just_pressed("use"):
						readingBook = false
						Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
						closeBook.emit()
			elif target is Button3D:
				displayText.text = target.name.capitalize()
				if Input.is_action_just_pressed("use"):
					target.press()

func _physics_process(delta):
	if !rotatingRelic and !readingBook:
		var input_dir = Input.get_vector("left", "right", "forward", "backward")
		if input_dir != Vector2.ZERO:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction != Vector3.ZERO:
			if GlobalStuff.tutorial:
				Movement.emit()
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
			if GlobalStuff.tutorial: Mousement.emit()
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
