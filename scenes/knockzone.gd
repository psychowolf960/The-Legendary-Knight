extends Area2D
@export var stream : AudioStream
var dB = 0
var drain = false
@onready var sprite = $"../Sprite"
var initial_position
var initial_height: float

func _ready():
	signalbus.connect("drain", on_drain) 
	initial_position = position.y
	initial_height = sprite.texture.get_height()
	print(initial_position, initial_height)

func _on_area_entered(_area):
	signalbus.emit_signal("knock", self)
	Audiomanager.play_sound(stream, dB)

func on_drain():
	drain = true

func _physics_process(_delta):
	if drain:
		for i in $"..".get_children():
			var new_position = initial_position-10 + initial_height
			sprite.position.y = new_position
			var tween = get_tree().create_tween().set_parallel(true)
			tween.tween_property(i, "scale", Vector2(1, 0), 3)
		if sprite.scale.y <= 0.02:
			drain = false
			$"..".queue_free()
