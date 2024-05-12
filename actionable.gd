extends Area2D

func _on_area_entered(area):
	print("enterd")
	signalbus.emit_signal("actionable")
