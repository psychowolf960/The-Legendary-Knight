extends Control

@export var stream : AudioStream
var dB = 30

class World extends Control:
	var label: String
	var x: int

	func _init(initial_label: String):
		self.label = initial_label	
		self.x = 0

@onready var world_1 = $"Select Screen"/HBoxContainer/World1
@onready var world_4 = $"Select Screen"/HBoxContainer/World4
@onready var world_2 = $"Select Screen"/HBoxContainer/World2
@onready var world_3 = $"Select Screen"/HBoxContainer/World3
@onready var level_label = $"Select Screen"/Panel/LevelLabel
@onready var sfxVolumeSlider = $"Options Screen/VBoxContainer/SFX"

@onready var sfx_preview = $"SFX Preview"
@onready var titleScreen = $"Title Screen"
@onready var selectScreen = $"Select Screen"
@onready var optionsScreen = $"Options Screen"

func _ready():
	Options.SFX_VOLUME_UPDATED.connect(optionsScreen._on_sfx_volume_signal)
	Options.BGM_VOLUME_UPDATED.connect(optionsScreen._on_bgm_volume_signal)
	worlds = [world_2, world_1, world_3, world_4]
	
	Options.loadData()


func _on_options_pressed():
	titleScreen.hide()
	selectScreen.hide()
	optionsScreen.show()


func _on_button_pressed():
	print("saved")
	Options.saveData()
	selectScreen.show()
	optionsScreen.hide()
	titleScreen.show()
	
func _on_sfx_volume_signal(new_value):
	sfxVolumeSlider.value = new_value

func _on_sfx_volume_slider_value_changed(value):
	Options.sfx_volume = value
	
	if (visible):
		sfx_preview.play()

var middle_index: int
var animation_duration: float
var animation_step: float
var selected_level = world_4


@onready var worlds = []
var world_indices = {}
var animation_in_progress = false

func animate_sliding(direction: String):
	animation_in_progress = true
	var hbox = $"Select Screen"/HBoxContainer
	var last_child = worlds[worlds.size()-1]
	for world in worlds:
		world.visible = true
		world.get_node("Icon").expand_mode = 2
		world.get_node("Icon").modulate = "ffffff71"
		world.get_node("Icon").stop()
	if direction == "left":
		hbox.move_child(last_child, 0)
		last_child.visible = false
		var last_world = worlds.pop_back()
		worlds.insert(0, last_world)
		selected_level = worlds[2]
	elif direction == "right":
		hbox.move_child(worlds[0], worlds.size() - 1)
		worlds[0].visible = false
		var first_world = worlds.pop_front()
		worlds.append(first_world)
		selected_level = worlds[1]
	selected_level.get_node("Icon").expand_mode = 0
	selected_level.get_node("Icon").modulate = "ffffff"
	level_label.text = selected_level.get_name()
	selected_level.get_node("Icon").play()
	animation_in_progress = false


func _on_play_pressed():
	if selected_level == world_4:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	elif selected_level == world_1:
		get_tree().change_scene_to_file("res://scenes/prudence.tscn")
	elif selected_level == world_2:
		print("world2")
	elif selected_level == world_3:
		print("world3")
	elif selected_level == world_4:
		print("world4")
	Audiomanager.play_sound(stream, dB)


func _on_exit_pressed():
	get_tree().quit()

func _on_left_pressed():
	animate_sliding("left")
				
func _on_right_pressed():
	animate_sliding("right")
