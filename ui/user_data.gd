extends Control
const ALBUM_OPTION:PackedScene=preload("res://ui/album_button.tscn")
@onready var selec_album=$TabContainer/GAL/MarginContainer/ScrollContainer/albums
@onready var display_album=$TabContainer/GAL/MarginContainer/AlbumDisplay
#@onready var scrolls:Array[ScrollContainer]=[$TabContainer/UNL/MarginContainer/ScrollContainer,$TabContainer/GAL/MarginContainer/ScrollContainer,$TabContainer/LOG/MarginContainer/ScrollContainer]
func _ready()->void:
	var con:ConfigFile=Iniload.con_screen
	for sec in con.get_sections():
		var button=ALBUM_OPTION.instantiate()
		button.text=sec
		var miniatura=con.get_value(sec,con.get_section_keys(sec)[-1])
		button.icon=Resouses.load_image(miniatura)
		selec_album.add_child(button)
		button.connect("selec",display_album.load_screenshot_album)
		#for node in scrolls:
			#var scroll=node.get_v_scroll_bar()
			#scroll.grabber_custom_minimum_size=Vector2(60,120)
