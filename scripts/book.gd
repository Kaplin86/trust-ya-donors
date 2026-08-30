extends StaticBody3D
class_name Book

@export var bookname = ""

func _ready():
	$Label3D.text = bookname.split("_")[0] + " "
	if bookname.split("_").size() >= 3:
		$Label3D.text += bookname.split("_")[2]
		$Sprite3D.texture = load("res://assets/bookcovers/"+bookname+".png")
