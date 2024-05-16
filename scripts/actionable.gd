extends Area2D

func _on_area_entered(_area):
	print("entered dialogue")
	signalbus.emit_signal("actionable")
