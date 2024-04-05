class_name DigimonBody extends CharacterBody2D
var dir:Vector2=Vector2.ZERO
var digimon_name:String
var player:bool=false
var animation_dir:String="down"
var animation_state:String="idel"
@export_group("freatures")
@export var Digimon_Id:int
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var attribute:DigimonCORE.attribut
@export var Evo_level:DigimonCORE.level_evo

@onready var core:DigimonCORE=get_parent()
@onready var _life:float:
	get:
		return _life+(_life*core.life)
@onready var _energy:float:
	get:
		return _energy+(_energy*core.energy)
@onready var _attack:float:
	get:
		return _attack+(_attack*core.attack)
@onready var _defend:float:
	get:
		return _defend+(_defend*core.defend)
@onready var _speed:float:
	get:
		return _speed+(_speed*core.speed)
@onready var _inteligent:float:
	get:
		return _inteligent+(_inteligent*core.inteligent)
@onready var _will:float:
	get:
		return _will+(_will*core.will)
@onready var _fighter:float:
	get:
		return _fighter+(_fighter*core.fighter)


func set_stats():
	var keys=["Digimon_Id","digimon_name","_life","_energy","_attack","_defend","_speed","_inteligent","_will","_fighter"]
	var new_stats=Base.base[Digimon_Id]
	var data_index=0
	while data_index<11:
		set(keys[data_index],new_stats[data_index])
	$Name.text=digimon_name+"mon"

func _ready():
	set_stats()
	core.attribute=attribute
	core.Evo_level=Evo_level
	core.max_life=_life
	core.max_energy=_energy
	core.current_life=_life
	core.current_energy=_energy
	core.body=self

func _process(delta):
	if player:_get_inputs()
	velocity=dir*delta
	
func _get_inputs():
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
