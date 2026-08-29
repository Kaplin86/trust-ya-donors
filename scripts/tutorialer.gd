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
	playSound("res://audio/tutorial/part2.wav")
	setText("I'll explain the job to ya. This is your office. You see that pedestal with two buttons?")
	await get_tree().create_timer(5.5).timeout
	setText("Thats a relic we got from a donor,")
	await get_tree().create_timer(1.8).timeout
	setText("Issue is, we cant TRUST YA DONORS! We have no way of knowing if the relics real, so thats YOUR job.")
	await get_tree().create_timer(14 - 8).timeout
	setText("The relic is a soda can. If you walk up to it and press E to spin it around with your mouse")
	await player.InspectRelic
	await get_tree().create_timer(1).timeout
	playSound("res://audio/tutorial/part3.wav")
	setText("And hit E again to stop spinning.")
	await player.unInspectRelic
	await get_tree().create_timer(1).timeout
	playSound("res://audio/tutorial/part4.wav")
	setText("Anywhom, if you look to the left of the pedestal, you see that bookself there?")
	await get_tree().create_timer(3.7).timeout
	setText("You can use the books in it to help figure out if a relic is real or not.")
	await get_tree().create_timer(8.6 - 3.7).timeout
	setText("Look for Food History Volume 1, and hit E on it to open.")
	var good = true
	while good:
		var result = await player.readBook
		if result == "food_history_vol1":
			good = false
	playSound("res://audio/tutorial/part5.wav")
	setText("Nice.")
	await get_tree().create_timer(0.9).timeout
	setText("Click the little 'thingamajig' on the right to go to the next page.")
	await player.PageChange
	playSound("res://audio/tutorial/part6.wav")
	setText("This is how you will be getting your facts on the relics.")
	await get_tree().create_timer(2.7).timeout
	setText("Most important information is in bold,")
	await get_tree().create_timer(4.8 - 2.7).timeout
	setText("So for this one, the soda can is in all capital A, 
	100% chemical usage,
	and bright red border on the edge of the can.")
	await get_tree().create_timer(12-4.8).timeout
	setText("Hit E again to close the book!")
	await  player.closeBook
	playSound("res://audio/tutorial/part7.wav")
	setText("Now go figure out if its real or not.
	hit either the red or green button.
	red for fake, green for real")
	var tween = create_tween()
	tween.tween_interval(12)
	tween.tween_property($CanvasLayer/CenterContainer,"modulate",Color.TRANSPARENT,0.22)
	await $"../IncomingRelicManager".answerChosen
	tween.cancel_free()
	playSound("res://audio/tutorial/part8.wav")
	setText("'Kay bud. I think your set. I'm gonna send you back now.")
	await get_tree().create_timer(4.3).timeout
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")

	
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
