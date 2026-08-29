extends Node3D
class_name RelicVotingManager

var remaining = ["first_soda","burger_mascot","burger_mascot","first_soda"]

@export var newitemDisplay : RelicDisplayPedestal

var correctAnswers = 0
var fakeRelicCount = 0
var realRelicCount = 0

signal dayEnd
signal answerChosen

func doRelic():
	if remaining == []:
		%Player.process_mode = Node.PROCESS_MODE_DISABLED
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		dayEnd.emit()
		return
	if GlobalStuff.tutorial:
		remaining = ["first_soda","first_soda","first_soda","first_soda","first_soda","first_soda","first_soda","first_soda","first_soda","first_soda","first_soda","first_soda"]
	var using = remaining.pop_front()
	var fake = [true,true,true,true,true,false].pick_random()
	if GlobalStuff.allowDuplicate:
		fake = [true,true,true,false].pick_random()
	if using in GlobalStuff.runsCurrentRelics and !GlobalStuff.allowDuplicate:
		fake = true
	newitemDisplay.type = using
	newitemDisplay.fake = fake
	newitemDisplay._update()

func _ready():
	doDay()

func doDay():
	remaining = GlobalStuff.getDaily()
	if GlobalStuff.noMoreAvailableRelics:
		if !GlobalStuff.allowDuplicate:
			%Player.process_mode = Node.PROCESS_MODE_DISABLED
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$"../DayEndDoer".doVictory()
			return
	doRelic()

func _on_real_pressed():
	answerChosen.emit()
	if newitemDisplay.fake == false:
		correctAnswers += 1
		GlobalStuff.runsCurrentRelics.append(newitemDisplay.type)
	doRelic()
	realRelicCount += 1

func _on_fake_pressed():
	answerChosen.emit()
	if newitemDisplay.fake == true:
		correctAnswers += 1
		#genuineRelicsObtained.append(newitemDisplay.type)
	fakeRelicCount += 1
	doRelic()
