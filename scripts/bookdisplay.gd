extends Control

var currentBook : String = ""
var bookDictionary : Dictionary = {}
var currentPage : int = 0

var opened = preload("res://assets/books.png")
var closed = preload("res://assets/bookcover.png")

signal pageChange

func _openBook(book):
	currentBook = book
	var data : JSON = load("res://bookdata/"+currentBook+".json")
	bookDictionary = data.data
	currentPage = -1
	%BookSFX.pitch_scale = randf_range(0.9,1.1)
	%BookSFX.play()
	visible = true
	updatePage()

func updatePage():
	if currentPage == -1:
		%OpenBookContents.visible = false
		%ClosedBookContents.visible = true
		
		%Title.text = "Book \n of \n [b]"+ currentBook.capitalize() + "[/b]"
		%Cover.texture = load("res://assets/bookcovers/"+currentBook+".png")
		
		%bg.texture = closed
		$Left.disabled = true
		$Right.disabled = false
	else:
		%OpenBookContents.visible = true
		%ClosedBookContents.visible = false
		$Left.disabled = false
		
		if currentPage == bookDictionary.keys().size() - 1:
			$Right.disabled = true
		else:
			$Right.disabled = false
		
		var keyName = bookDictionary.keys()[currentPage]
		print(keyName)
		%Name.text = bookDictionary[keyName]["title"]
		%Desc.text = bookDictionary[keyName]["description"]
		%Entry.text = "Entry #" + str(currentPage + 1)
		
		%bg.texture = opened


func _on_node_3d_close_book():
	visible = false


func _on_left_pressed():
	pageChange.emit()
	currentPage -= 1
	updatePage()
	
	%Click.play()

func _on_right_pressed():
	pageChange.emit()
	currentPage += 1
	updatePage()
	
	%Click.play()
