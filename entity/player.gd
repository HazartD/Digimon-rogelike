class_name Player extends CharacterBody2D
const SPEEDMOVE=9000
var time:float=0.0
var digimon_id:float=1
var data:Array[float]=[]
var player_name:String
var life:float=100.0:
	get:
		return life+(life*Iniload.statsplus["life"])
var energy:float=120.0:
	get:
		return energy+(energy*Iniload.statsplus["energy"])
var attack:float=102.0:
	get:
		return attack+(attack*Iniload.statsplus["attack"])
var defend:float=102.0:
	get:
		return defend+(defend*Iniload.statsplus["defend"])
var speed:float=102.0:
	get:
		return speed+(speed*Iniload.statsplus["speed"])
var inteligent:float=210.0:
	get:
		return inteligent+(inteligent*Iniload.statsplus["inteligent"])
var will:float=102.0:
	get:
		return will+(will*Iniload.statsplus["will"])
var fighter:float
var air_move:bool
var groud_move:bool
var water_move:bool
var input_vector:Vector2=Vector2.ZERO
func _ready():
	dead()
	print(life)
func _process(delta):
	time+=delta
func _physics_process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	#gracias a xXtumbaBurrasXx del discord de godot por la idea
	velocity=input_vector*SPEEDMOVE*delta
	move_and_slide()
func dead():
	var save_data={
	"time":time,
	"player_name":player_name,
	"digimon_id":digimon_id,
	"life":life,
	"energy":energy,
	"attack":attack,
	"defend":defend,
	"speed":speed,
	"inteligent":inteligent,
	"will":will}
	Iniload.savedead(save_data)


