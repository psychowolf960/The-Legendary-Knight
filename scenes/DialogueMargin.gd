extends MarginContainer

@onready var dialogue_box = $DialogueBox

func _ready():
	signalbus.connect("dialogue", on_dialogue) 

func on_dialogue():
	print('talking')
	dialogue_box.start('START')
