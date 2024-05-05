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
var selected_level = "idk"

func animate_sliding(direction: String):
	if direction == "right":
		_start_animation_right()

@onready var worlds = []
var world_indices = {}
var animation_in_progress = false

func _ready():
	worlds = [world_1, world_2, world_3, world_4]

func _start_animation_right():
	animation_in_progress = true
	var hbox = $MarginContainer2/HBoxContainer
	var last_child = worlds[worlds.size()-1]
	hbox.move_child(last_child, 0) # Moves last child to index zero, which reorders all children
	
	selected_level = last_child.name
	print("selected level: ", last_child.name)

	var last_world = worlds.pop_back()
	worlds.insert(0, last_world)

	animation_in_progress = false

func _on_play_pressed():
	if selected_level == "idk":
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	elif selected_level == "World1":
		get_tree().change_scene_to_file("res://scenes/prudence.tscn")
	elif selected_level == "World2":
		print("world2")
	elif selected_level == "World3":
		print("world3")
	elif selected_level == "World4":
		print("world4")

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
			print("work")
			print(worlds)
