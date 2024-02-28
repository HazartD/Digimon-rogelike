class_name DigimonBody extends CharacterBody2D
enum attribut{VA,DA,VI,FR,UNK}
enum level_evo{BABYI,BABYII,CHILD,ADULT,PERFECT,ULTIMATE}

var digimon_name:String
var IA_type:int=0

@onready var core:DigimonCORE=get_node("..")

@export_group("freatures")
@export var Digimon_Id:int
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var attribute:attribut
@export var Evo_level:level_evo

@export_group("stats_base")
@export var _life:float:
	get:
		return _life+(_life*core.life)
@export var _energy:float:
	get:
		return _energy+(_energy*core.energy)
@export var _attack:float:
	get:
		return _attack+(_attack*core.attack)
@export var _defend:float:
	get:
		return _defend+(_defend*core.defend)
@export var _speed:float:
	get:
		return _speed+(_speed*core.speed)
@export var _inteligent:float:
	get:
		return _inteligent+(_inteligent*core.inteligent)
@export var _will:float:
	get:
		return _will+(_will*core.will)
@export var _fighter:float:
	get:
		return _fighter+(_fighter*core.fighter)

func _init():
	ready.connect(set_stats)

func set_stats():
	var keys=["Digimon_Id","digimon_name","_life","_energy","_attack","_defend","_speed","_inteligent","_will","_fighter","groud_move","water_move","air_move","IA_type","attribute","Evo_level"]
	var new_stats=Base.base[Digimon_Id]
	var data_index=0
	while data_index<15:
		set(keys[data_index],new_stats[data_index])
	$Name.text=digimon_name+"mon"
	var new_IA:Script
	match IA_type:
		0:
			new_IA=load("res://entity/IA/test.gd")

func _ready():
	pass
