extends PanelContainer

func _ready():
	$MC/HB/accion/bgm.value=AudioServer.get_bus_volume_db(1)
	$MC/HB/accion/sfx.value=AudioServer.get_bus_volume_db(2)
	$MC/HB/accion/ui.value=AudioServer.get_bus_volume_db(3)
	if DisplayServer.window_get_mode()==0:$MC/HB/accion/full.button_pressed=false
	elif DisplayServer.window_get_mode()==3:$MC/HB/accion/full.button_pressed=true
func _input(event):
	if event.is_action("ui_cancel"):
		queue_free()

func _on_bgm_value_changed(value):
	AudioServer.set_bus_volume_db(1,value)


func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(2,value)


func _on_ui_value_changed(value):
	AudioServer.set_bus_volume_db(3,value)


func _on_full_toggled(to):
	if to:DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



func _on_button_button_down():
	if TranslationServer.get_locale()=="es":TranslationServer.set_locale("en")
	else:TranslationServer.set_locale("es")
