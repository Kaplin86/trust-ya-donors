extends Node3D

var remaining = ["first_soda","burger_mascot","burger_mascot","first_soda"]

@export var newitemDisplay : RelicDisplayPedestal

var correctAnswers = 0
var genuineRelicsObtained = []

signal dayEnd

func doRelic():
	var using = remaining.pop_front()
	var fake = [true,true,true,false,false,false,false].pick_random()
	if using in genuineRelicsObtained:
		fake = true
	newitemDisplay.type = using
	newitemDisplay.fake = fake
	newitemDisplay._update()

func _ready():
	doDay()

func doDay():
	remaining = GlobalStuff.getDaily()
	doRelic()

func _on_real_pressed():
	if newitemDisplay.fake == false:
		correctAnswers += 1
		genuineRelicsObtained.append(newitemDisplay.type)
	doRelic()

func _on_fake_pressed():
	if newitemDisplay.fake == true:
		correctAnswers += 1
		#genuineRelicsObtained.append(newitemDisplay.type)
	doRelic()
