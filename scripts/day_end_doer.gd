extends Node3D

@export var incomingRelicManager : RelicVotingManager

var group1 = [%RelicsAccepted,%RelicsDenied,%RelicsFoundContainer,%HSeparator2]
var group2 = [%FinalResult, %Result, %ResultImage, %Finish,%ResultingText]

var timerKill = false

var percentageToResult = {
	0.0:"BRO.",
	0.1:"FIRED",
	0.7:"DO BETTER",
	0.9:"SATISFACTORY",
	1.0:"PERFECTION"
}

var isWin = {
	"BRO.":false,
	"FIRED":false,
	"DO BETTER":true,
	"SATISFACTORY":true,
	"PERFECTION":true
}

var won = true

func _ready():
	group1 = [%RelicsAccepted,%RelicsDenied,%RelicsFoundContainer,%HSeparator2]
	group2 = [%FinalResult, %Result, %ResultImage, %Finish,%ResultingText]

func _on_incoming_relic_manager_day_end():
	GlobalStuff.Day += 1
	
	for I in group1: I.visible = false
	for I in group2: I.visible = false
	
	%Day.text = "Day " + str(int(GlobalStuff.Day))
	
	$CanvasLayer.visible = true
	%ExtendedService.visible = false
	$CanvasLayer/Panel.offset_transform_position_ratio = Vector2(0,-1.115)
	var newTween = create_tween()
	newTween.set_trans(Tween.TRANS_BOUNCE)
	newTween.set_ease(Tween.EASE_OUT)
	newTween.tween_property($CanvasLayer/Panel,"offset_transform_position_ratio",Vector2(0,0),1)
	%PaperSlide.play()
	await newTween.finished
	await get_tree().create_timer(1).timeout
	
	%EndClick.play()
	
	%RelicsAccepted.text = "RELICS ACCEPTED: [b]" + str(incomingRelicManager.realRelicCount)
	%RelicsDenied.text = "RELICS DENIED: [b]" + str(incomingRelicManager.fakeRelicCount)
	
	
	for I in group1: I.visible = true
	await get_tree().create_timer(1).timeout
	%EndClick.play()
	newTween = create_tween()
	newTween.set_trans(Tween.TRANS_CUBIC)
	newTween.set_ease(Tween.EASE_OUT)
	%ResultImage.offset_transform_scale = Vector2(5,5)
	newTween.tween_property(%ResultImage,"offset_transform_scale",Vector2.ONE,0.2)
	
	var totalRelicCount = incomingRelicManager.realRelicCount + incomingRelicManager.fakeRelicCount
	var percent = incomingRelicManager.correctAnswers/float(totalRelicCount)
	var result = ""
	for I in percentageToResult:
		if percent >= I:
			result = percentageToResult[I]
	if timerKill:
		result = "FIRED"
	%Result.text = result
	
	%ResultingText.text = "("+str(percent * 100) + "% accuracy)"
	if timerKill:
		%ResultingText.text = "(by timer)"
	
	for I in group2: I.visible = true
	if !timerKill:
		won =  isWin[result]
		if isWin[result]:
			%Finish.text = "Continue to NEXT DAY"
		else:
			%Finish.text = "Walk home in SHAME"
	else:
		won = false
		%Finish.text = "Walk home in SHAME"

func _on_finish_pressed():
	if won:
		Transition.to_scene("res://scenes/main.tscn")
	else:
		Transition.to_scene("res://scenes/mainmenu.tscn")

func doVictory():
	await get_tree().process_frame
	GlobalStuff.Day += 1
	
	for I in group1: I.visible = false
	for I in group2: I.visible = false
	
	%Day.text = "Day " + str(int(GlobalStuff.Day))
	
	$CanvasLayer.visible = true
	$CanvasLayer/Panel.offset_transform_position_ratio = Vector2(0,-1.115)
	var newTween = create_tween()
	newTween.set_trans(Tween.TRANS_BOUNCE)
	newTween.set_ease(Tween.EASE_OUT)
	newTween.tween_property($CanvasLayer/Panel,"offset_transform_position_ratio",Vector2(0,0),1)
	await newTween.finished
	await get_tree().create_timer(1).timeout
	won = false
	%ExtendedService.visible = true
	%ResultImage.visible = true
	%Finish.visible = true
	%Finish.text = "Main Menu"
	%Win.play()

func _on_canvas_layer_timer_end():
	timerKill = true
	_on_incoming_relic_manager_day_end()
