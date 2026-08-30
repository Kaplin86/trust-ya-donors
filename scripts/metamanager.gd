extends Node

var DATAPATH = "user://totaldata.json"

var currentData : Dictionary = {}
var defaultDataFormat = {"encounters":0,"incorrectFake":0,"incorrectReal":0,"correctReal":0,"correctFake":0} #this is per each relic


func _ready():
	var opening = FileAccess.open(DATAPATH,FileAccess.READ)
	
	if opening == null:
		return
	
	var text = opening.get_as_text()
	
	if text == "":
		currentData = {}
	else:
		print(currentData)
		currentData = JSON.parse_string(text)

func save():
	print(currentData)
	var opening = FileAccess.open(DATAPATH,FileAccess.WRITE)
	var result = opening.store_string(JSON.stringify(currentData))
	opening.close()

func _changeData(relic,property,difference):
	var relicData = currentData.get_or_add(relic,defaultDataFormat.duplicate())
	relicData[property] += difference
	relicData["encounters"] += 1
	save()

func incorrectFake(relic : String): _changeData(relic,"incorrectFake",1)


func incorrectReal(relic : String): _changeData(relic,"incorrectReal",1)


func correctReal(relic : String): _changeData(relic,"correctReal",1)


func correctFake(relic : String): _changeData(relic,"correctFake",1)
