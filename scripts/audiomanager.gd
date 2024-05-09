extends Node

func play_sound(stream: AudioStream, dB: float = 0.0, pitch: float = 1.0):
	var instance = AudioStreamPlayer2D.new()
	
	instance.stream = stream
	instance.volume_db = dB
	instance.pitch_scale = pitch
	instance.attenuation = 2
	instance.finished.connect(remove_node.bind(instance))
	add_child(instance)
	instance.play()
	
func remove_node(object):
	object.queue_free()
