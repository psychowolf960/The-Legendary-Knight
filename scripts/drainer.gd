extends Area2D
@export var stream : AudioStream
var dB = 0
var drain = false

@onready var sprite = $"../Drainer/Sprite"

func _on_area_entered(_area):
	print("hi")
	signalbus.emit_signal("drain")
	Audiomanager.play_sound(stream, dB)
	drain = true

func _physics_process(delta):
	if drain == true:
		sprite.hide()
		if sprite.visible == false:
			$"..".queue_free()
			drain = false
