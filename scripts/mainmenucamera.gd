extends Camera3D

func _ready():
	playRandomAnim()

var lastAnim = ""

func playRandomAnim():
	var anims = Array($AnimationPlayer.get_animation_list())
	anims.erase("RESET")
	anims.erase(lastAnim)
	lastAnim = anims.pick_random()
	$AnimationPlayer.play(lastAnim)

func _on_animation_player_animation_finished(anim_name):
	#await get_tree().create_timer(1).timeout
	playRandomAnim()
