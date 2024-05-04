extends Control

class World extends Control:
	var label: String
	var x: int

	func _init(initial_label: String):
		self.label = initial_label	
		self.x = 0

@onready var world_1 = $MarginContainer2/HBoxContainer/World1

@onready var world_2 = $MarginContainer2/HBoxContainer/World2
@onready var world_3 = $MarginContainer2/HBoxContainer/World3

var middle_index: int
var animation_duration: float
var animation_step: float

func animate_sliding(direction: String):
	if direction == "right":
		_start_animation_right()

@onready var worlds = []
var world_indices = {}
var animation_in_progress = false

func _ready():
	worlds = [world_1, world_2, world_3]
	for i in range(worlds.size()):
		world_indices[worlds[i]] = i + 1

func _start_animation_right():
	animation_in_progress = true
	var hbox = $MarginContainer2/HBoxContainer
	for world in worlds:
		if world_indices[world] == 4:
			world_indices[world] = 1
		else:
			world_indices[world] += 1
	for i in range(worlds.size()):
		hbox.move_child(worlds[i], world_indices[worlds[i]] - 1)
	
	# Print tests to check if the nodes have correctly moved inside the HBoxContainer
	print("After animation, the order of worlds in this damn HBoxContainer is:")
	for i in range(hbox.get_child_count()):
		print(hbox.get_child(i).name)
	
	for world in worlds:
		print("Mfckin World ", world.name, " is at index ", world_indices[world])
	
	animation_in_progress = false

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/optionsmenu.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _input(event: InputEvent):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_right") and not animation_in_progress:
			print("ok")
			animate_sliding("right")
		elif Input.is_action_just_pressed("ui_left") and not animation_in_progress:
			print(world_indices)
			print("work")
			print(worlds)
