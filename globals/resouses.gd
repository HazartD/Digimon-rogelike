extends Node
const DEAD : Shader = preload("res://img/shader/dead.gdshader")
const NOISE_NORMAL : NoiseTexture2D = preload("res://img/shader/dead_noise_1.tres")
const NOISE : NoiseTexture2D = preload("res://img/shader/dead_noise_2.tres")
const DIGIMON_EVENTS=[preload("res://other scene/event_flee.tscn"),preload("res://other scene/event_block.tscn"),preload("res://other scene/event_no_dead.tscn")]
const MENU_OPTIONS:PackedScene=preload("res://ui/opciones.tscn")
const ERROR_LOAD_IMAGE:CompressedTexture2D=preload("res://img/load_error.png")
const TAMA:PackedScene=preload("res://entity/tama.tscn")
var last_10_screenshots:Dictionary={}
func _ready()->void:
	DEAD.set("shader_parameter/noise_tex_normal",NOISE_NORMAL)
	DEAD.set("shader_parameter/noise_tex",NOISE)
func add_screenshot(path:String,texture)->void:
	var keys=last_10_screenshots.keys()
	if keys.size()>9:last_10_screenshots.erase(keys[-1])
	last_10_screenshots[path]=texture

func load_image(path)->Texture:
	var error=Image.load_from_file(path)
	if error==null:return ERROR_LOAD_IMAGE
	else:return ImageTexture.create_from_image(error)
