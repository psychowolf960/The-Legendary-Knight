extends Node

var score = 0

@onready var score_label = get_node_or_null("ScoreLabel")

func add_point():
	if score_label:
		score += 1
		score_label.text = "You collected " + str(score) + " coins."

func _on_player_mouse_entered():
	pass # Replace with function body.
