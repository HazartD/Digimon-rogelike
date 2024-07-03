extends Control
const ALBUM_OPTION:PackedScene=preload("res://ui/album_button.tscn")
@onready var selec_album=$TabContainer/GAL/MarginContainer/ScrollContainer/albums
@onready var display_album=$TabContainer/GAL/MarginContainer/AlbumDisplay
func _ready():
	var con:ConfigFile=Iniload.con_screen
	for sec in con.get_sections():
		var button=ALBUM_OPTION.instantiate()
		button.text=sec
		var miniatura=con.get_value(sec,con.get_section_keys(sec)[-1])
		if FileAccess.file_exists(miniatura):
			button.icon=ImageTexture.create_from_image(Image.load_from_file(miniatura))
		else:button.icon=Resouses.ERROR_LOAD_IMAGE
		selec_album.add_child(button)
		button.connect("selec",display_album.load_screenshot_album)
