extends Node3D

@export var incomingRelicManager : Node3D

@onready var group1 = [%RelicsAccepted,%RelicsDenied,%RelicsFoundContainer,%HSeparator2]
@onready var group2 = [%FinalResult, %Result, %ResultImage, %Finish]

func _on_incoming_relic_manager_day_end():
	for I in group1: I.visible = false
	for I in group2: I.visible = false
	
	$CanvasLayer.visible = true
	$CanvasLayer/Panel.offset_transform_position_ratio = Vector2(0,-1.115)
	var newTween = create_tween()
	newTween.set_trans(Tween.TRANS_BOUNCE)
	newTween.set_ease(Tween.EASE_OUT)
	newTween.tween_property($CanvasLayer/Panel,"offset_transform_position_ratio",Vector2(0,0),1)
	await newTween.finished
	await get_tree().create_timer(1).timeout
	for I in group1: I.visible = true
	await get_tree().create_timer(1).timeout
	newTween = create_tween()
	newTween.set_trans(Tween.TRANS_CUBIC)
	newTween.set_ease(Tween.EASE_OUT)
	%ResultImage.offset_transform_scale = Vector2(5,5)
	newTween.tween_property(%ResultImage,"offset_transform_scale",Vector2.ONE,0.2)
	for I in group2: I.visible = true

func _ready():
	_on_incoming_relic_manager_day_end()
