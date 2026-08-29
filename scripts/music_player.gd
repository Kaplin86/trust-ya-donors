extends Node3D

@export var LofiModeSongs : Array[AudioStream] = []
@export var Player : AudioStreamPlayer

var playList = []

func _ready():
	redoPlaylist()

func redoPlaylist():
	playList = LofiModeSongs.duplicate()
	playList.shuffle()
	for I in playList:
		Player.stream = I
		Player.play()
		await Player.finished
	redoPlaylist()
