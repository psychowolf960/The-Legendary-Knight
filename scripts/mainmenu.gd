extends Control

class World extends Control:
	var label: String
	var x: int

	func _init(initial_label: String):
		self.label = initial_label	
		self.x = 0

@onready var world_1 = $MarginContainer2/HBoxContainer/World1
@onready var world_4 = $MarginContainer2/HBoxContainer/World4
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
	var world_1_obj = World.new("World 1")
	var world_2_obj = World.new("World 2")
	var world_3_obj = World.new("World 3")
	var world_4_obj = World.new("World 4")

	world_1.add_child(world_1_obj)
	world_2.add_child(world_2_obj)
	world_3.add_child(world_3_obj)
	world_4.add_child(world_4_obj)

	worlds.append(world_1_obj)
	worlds.append(world_2_obj)
	worlds.append(world_3_obj)
	worlds.append(world_4_obj)

	world_indices[world_1_obj] = 1
	world_indices[world_2_obj] = 2
	world_indices[world_3_obj] = 3
	world_indices[world_4_obj] = 4

func _start_animation_right():
	animation_in_progress = true
	var hbox = $MarginContainer2/HBoxContainer
	var temp_worlds = worlds.duplicate()
	for i in range(temp_worlds.size()):
		if world_indices[temp_worlds[i]] == 4:
			world_indices[temp_worlds[i]] = 1
		else:
			world_indices[temp_worlds[i]] += 1
	for i in range(temp_worlds.size()):
		if world_indices[temp_worlds[i]] == 1:
			hbox.move_child(temp_worlds[i].get_parent(), 0)
		elif world_indices[temp_worlds[i]] == 2:
			hbox.move_child(temp_worlds[i].get_parent(), 1)
		elif world_indices[temp_worlds[i]] == 3:
			hbox.move_child(temp_worlds[i].get_parent(), 2)
		elif world_indices[temp_worlds[i]] == 4:
			hbox.move_child(temp_worlds[i].get_parent(), 3)
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
			print("gay")
			animate_sliding("right")
		elif Input.is_action_just_pressed("ui_left") and not animation_in_progress:
			print(world_indices)
			print("work")
			print(worlds)
