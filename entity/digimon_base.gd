class_name DigimonBase extends CharacterBody2D
const BASE_SPEED=10000
@export var Digimon_Id:int
@export var digimon_name:String
@export_group("stats")
@export var life:float=100.0
@export var energy:float=120.0
@export var attack:float=102.0
@export var defend:float=102.0
@export var speed:float=102.0#la speed tambien afecta al movimiento
@export var inteligent:float=210.0
@export var will:float=102.0
@export var fighter:float

var direction:Vector2=Vector2.ZERO

func stats_set():
	var new_stats=Base.base[Digimon_Id]
	for key in new_stats.keys():
		set(key,new_stats[key])
	
