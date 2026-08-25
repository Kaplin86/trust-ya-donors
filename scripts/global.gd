extends Node

var relics = [
	"first_soda",
	"burger_mascot"
]

var runsCurrentRelics = []

func getDaily():
	var availableRelics = relics.duplicate()
	var relicSet = []
	for I in runsCurrentRelics:
		availableRelics.erase(I)
	for I in 5:
		var relicChosen = availableRelics.pick_random()
		relicSet.append(relicChosen)
	return relicSet
