extends Control

@onready var dialogue_box = $MarginContainer/DialogueBox

func _ready():
	signalbus.connect("dialogue", on_dialogue) 
	
func on_dialogue():
	print("daim la team")
	dialogue_box.start('START')
