extends Node



var relics = [
	"first_soda",
	"burger_mascot",
	"frog_along_the_shore",
	"mona_lisa",
	"creator",
	"starry_night",
	"the_scream",
	"ancient_vase"
]

var Day = 0
var tutorial = true
var timer = true

var runsCurrentRelics = []

var allowDuplicate = true

func getDaily():
	var availableRelics = relics.duplicate()
	var relicSet = []
	if !allowDuplicate:
		for I in runsCurrentRelics:
			availableRelics.erase(I)
	if availableRelics == []:
		availableRelics = relics.duplicate()
	for I in 5:
		var relicChosen = availableRelics.pick_random()
		relicSet.append(relicChosen)
	
	return relicSet
