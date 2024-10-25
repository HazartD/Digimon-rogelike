extends Control
@onready var view_screenshot=$ScrollContainer/VBoxContainer
func update_album(_a=null,_e=null):
	if visible:
		var screen=Resouses.last_10_screenshots.values()
		for texrec in view_screenshot.get_children():
			var i=int(String(texrec.name))
			if i<screen.size():texrec.texture=screen[i]
func _ready():
	Iniload.screenshot.connect(update_album,CONNECT_DEFERRED)
func _input(event)->void:if event.is_action_pressed("ui_cancel"):visible=!visible

func _on_visibility_changed()->void:
	get_tree().paused=visible#true if visible else false
	update_album()
	print("menu es:",visible," tree es:",get_tree().paused)
