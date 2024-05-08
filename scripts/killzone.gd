extends Area2D

@onready var timer = $Timer
@onready var destructible = $".."
signal hit

func _throw_parent_out_of_screen(body: Node2D):
	# Create a tween to throw the parent node out of the screen
	var tween = create_tween()
	tween.set_parallel(true)
	timer.start()
	tween.tween_property(destructible, "position", Vector2(destructible.position.x + randf_range(-100, 100), destructible.position.y - 300), 2)
	if timer.get_time_left() == 0:
		destructible.queue_free()

func _on_body_entered(body):
	signalbus.emit_signal("_hit", hit)
	_throw_parent_out_of_screen(body)
	print("yes")

func _process(delta):
	if timer.get_time_left() > 0 and destructible.has_method("rotate"):
		destructible.rotate(20 * delta)
