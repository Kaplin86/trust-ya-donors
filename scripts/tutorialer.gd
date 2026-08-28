extends Node3D

@export var stream : AudioStreamPlayer3D

@export var player : Character

func _ready():
	if !GlobalStuff.tutorial:
		return
	await get_tree().create_timer(1).timeout
	playSound("res://audio/tutorial/part1.wav")
	setText("You must be the new guy, huh?")
	await get_tree().create_timer(1.6).timeout
	setText("Don't worry, you won't see me. 
	I'm in one of them boxes in the corner.")
	await get_tree().create_timer(6.55 - 1.7).timeout
	setText("This job is best done alone, I say from experience.")
	await get_tree().create_timer(10 - 6.55).timeout
	setText("First things first, use WASD to move, and mouse to look around")
	await get_tree().create_timer(3).timeout
	await player.Mousement
	await player.Movement
	

func playSound(sound : String):
	var streamthing = load(sound)
	stream.stream = streamthing
	stream.play()

func setText(text):
	var tween = create_tween()
	tween.tween_property($CanvasLayer/CenterContainer,"modulate",Color.TRANSPARENT,0.22)
	tween.tween_property($CanvasLayer/CenterContainer,"modulate",Color.WHITE,0.2)
	await get_tree().create_timer(0.2).timeout
	$CanvasLayer/CenterContainer/Label.text = text
	tween.tween_property($CanvasLayer/CenterContainer,"modulate",Color.WHITE,0.2)
