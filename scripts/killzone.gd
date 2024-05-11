extends Area2D
@export var stream : AudioStream
@onready var timer = $Timer
@onready var destructible = $".."

var dB = 30
var started = false

func _on_body_entered(_body):
	print("hit")
	signalbus.emit_signal("_hit")
	var tween = create_tween()
	tween.set_parallel(true)
	timer.start()
	started = true
	tween.tween_property(destructible, "position", Vector2(destructible.position.x + randf_range(-100, 100), destructible.position.y - 300), 2)
	Audiomanager.play_sound(stream, dB)

func _process(delta):
	if started == true:
		if timer.get_time_left() == 0 and destructible != TileMap:
			destructible.queue_free()
		if timer.get_time_left() > 0 and destructible.has_method("rotate"):
			destructible.rotate(20 * delta)

