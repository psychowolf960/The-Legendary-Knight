extends Area2D

@onready var timer = $Timer
@onready var destructible = $".."
signal hit

func _on_body_entered(_body):
	signalbus.emit_signal("_hit")
	var tween = create_tween()
	tween.set_parallel(true)
	timer.start()
	tween.tween_property(destructible, "position", Vector2(destructible.position.x + randf_range(-100, 100), destructible.position.y - 300), 2)

func _process(delta):
	if timer.get_time_left() > 0 and destructible.has_method("rotate"):
		destructible.rotate(20 * delta)
	elif timer.get_time_left() == 0:
		destructible.queue_free()
