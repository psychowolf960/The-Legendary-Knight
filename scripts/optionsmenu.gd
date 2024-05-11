extends Control

@onready var sfxVolumeSlider = $"VBoxContainer/SFX/MarginContainer/HSlider"
@onready var sfx_preview = $OptionsScreen/SFXPreview
@onready var titleScreen = $"Title Screen"
@onready var optionsScreen = $"Options Screen"

func _ready():
	Options.SFX_VOLUME_UPDATED.connect(optionsScreen._on_sfx_volume_signal)
	Options.BGM_VOLUME_UPDATED.connect(optionsScreen._on_bgm_volume_signal)
	
	Options.loadData()


func _on_options_pressed():
	titleScreen.hide()
	optionsScreen.show()


func _on_button_pressed():
	print("saved")
	Options.saveData()
	optionsScreen.hide()
	titleScreen.show()
	
func _on_sfx_volume_signal(new_value):
	sfxVolumeSlider.value = new_value

func _on_sfx_volume_slider_value_changed(value):
	Options.sfx_volume = value
	
	if (visible):
		sfx_preview.play()
