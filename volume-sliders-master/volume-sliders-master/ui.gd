extends Control

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
	Options.saveData()
	optionsScreen.hide()
	titleScreen.show()
