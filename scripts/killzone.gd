extends Area2D

@onready var timer = $Timer
@onready var parent_node =  $".."

func _on_body_entered(body: Node2D):
	print("You got punched!")
	_throw_parent_out_of_screen(body)

func _throw_parent_out_of_screen(body: Node2D):
	# Create a tween to throw the parent node out of the screen
	var tween = create_tween()
	tween.set_parallel(true)
	# Throw up
	tween.tween_property(parent_node, "position:y", -50, 0.5)  # adjust the value to your liking
	tween.tween_property(parent_node, "linear_velocity:y", -100, 0.5)  # adjust the value to your liking

	# Wait for the tween to finish
	await tween.finished

	# Add gravity
	parent_node.linear_velocity.y = 0
	parent_node.add_constant_velocity(Vector2(0, 100))  # adjust the value to your liking

	# Rotate the node while it's in the air
	var rotation_tween = create_tween()
	rotation_tween.tween_property(parent_node, "rotation", PI * 2, 1.5)  # rotate 360 degrees in 1.5 seconds
	rotation_tween.play()


func _on_throw_finished():
	pass
