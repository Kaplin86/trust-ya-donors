extends Node

var relicsE = [
	"first_soda",
	"burger_mascot",
	"frog_along_the_shore",
	"mona_lisa",
	"creator",
	"starry_night",
	"the_scream"
]

var relics = ["ancient_vase"]

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
