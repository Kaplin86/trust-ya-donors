extends RetexturingRelic

func _ready():
	if GlobalStuff.metaMuseum:
		if Metamanager.currentData.has(relic):
			visible = true
		else:
			visible = false
	else:
		if GlobalStuff.runsCurrentRelics.has(relic):
			visible = true
		else:
			visible = false
