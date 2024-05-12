extends Area2D
@export var stream : AudioStream
var dB = 0
func _on_body_entered(_body):
	signalbus.emit_signal("knock")
	Audiomanager.play_sound(stream, dB)
