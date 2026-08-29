extends CanvasLayer

signal timerEnd

func _ready():
	visible = false
	if !GlobalStuff.timer:
		return
	visible = true
	print("step one", GlobalStuff.Day**1)
	var time = 1.0/((GlobalStuff.Day**1) + 1) * 5 * 60
	$Timer.wait_time = time
	$Timer.start()

func _process(delta):
	var minutes = int($Timer.time_left / 60.0)
	var seconds = int(fmod($Timer.time_left, 60.0))
	var msec = int(fmod($Timer.time_left, 1.0) * 100)
	$PanelContainer/RichTextLabel.text = "%02d:%02d:%02d" % [minutes, seconds, msec]


func _on_timer_timeout():
	timerEnd.emit()


func _on_incoming_relic_manager_day_end():
	$Timer.stop()
