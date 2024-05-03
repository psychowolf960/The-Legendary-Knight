extends Control

class World:
	var label: String
	var x: int

	func _init(initial_label: String):
		self.label = initial_label	
		self.x = 0
@onready var world_1 = $MarginContainer2/World1
@onready var world_4 = $MarginContainer2/World4
@onready var world_2 = $MarginContainer2/World2
@onready var world_3 = $MarginContainer2/World3

var middle_index: int
var animation_duration: float
var animation_step: float

func animate_sliding(direction: String):
	if direction == "right":
		_start_animation_right()

var worlds = [world_1, world_2, world_3, world_4]
var world_indices = {world_1: 1, world_2: 2, world_3: 3, world_4: 4}
var animation_in_progress = false

func _start_animation_right():
	animation_in_progress = true
	for world in worlds:
			if world_indices[world] == 4:
				world_indices[world] = 1
			else:
				world_indices[world] += 1
	for world in worlds:
			if world_indices[world] == 1:
				world.set_position(Vector2(-185, 0))
				world.show()
			elif world_indices[world] == 2:
				world.set_position(Vector2(0, 0))
				world.show()
			elif world_indices[world] == 3:
				world.set_position(Vector2(185, 0))
				world.show()
			elif world_indices[world] == 4:
				world.set_position(Vector2(185, 0))
				world.hide()
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
			print("work")
			animate_sliding("left")
