extends MarginContainer
var screen=Resouses.last_10_screenshots
func _input(event)->void:if event.is_action_pressed("ui_cancel"):visible=!visible

func _on_visibility_changed()->void:
	get_tree().paused=visible#true if visible else false
	print("menu es:",visible," tree es:",get_tree().paused)
