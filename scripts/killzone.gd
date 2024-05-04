extends Area2D

@onready var timer = $Timer
@onready var destructible = $".."

func _on_body_entered(body: Node2D):
	print("You got punched!")
	_throw_parent_out_of_screen(body)

func _throw_parent_out_of_screen(body: Node2D):
	# Create a tween to throw the parent node out of the screen
	var tween = create_tween()
	tween.set_parallel(true)
	timer.start()
	tween.tween_property(destructible, "position:y", 1000, 900)  # adjust the value to your liking
	if timer.get_time_left() == 0:
		destructible.queue_free()

func _process(delta):
	if timer.get_time_left() > 0 and destructible.has_method("rotate"):
		print("rotate")
		destructible.rotate(20 * delta)
