extends Node
#const DEAD : Shader = preload("res://img/shader/dead.gdshader")
#const NOISE_NORMAL : NoiseTexture2D = preload("res://img/shader/dead_noise_1.tres")
#const NOISE : NoiseTexture2D = preload("res://img/shader/dead_noise_2.tres")
#const DIGIMON_EVENTS=[preload("res://other scene/event_flee.tscn"),preload("res://other scene/event_block.tscn"),preload("res://other scene/event_no_dead.tscn")]
#const MENU_OPTIONS:PackedScene=preload("res://ui/opciones.tscn")
const ERROR_LOAD_IMAGE:CompressedTexture2D=preload("res://img/load_error.png")
var last_10_screenshots:Dictionary={}
func add_screenshot(path:String,texture):
	var keys=last_10_screenshots.keys()
	if keys.size()>9:last_10_screenshots.erase(keys[-1])
	last_10_screenshots[path]=texture
