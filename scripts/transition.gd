extends CanvasLayer

func to_scene(string):
	$AnimationPlayer.speed_scale = 1
	$AnimationPlayer.play("in")
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(string)
	$AnimationPlayer.play_backwards("in")
