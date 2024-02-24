class_name DigimonBase extends CharacterBody2D
const BASE_SPEED=10000
@export var Digimon_Id:int
@export var digimon_name:String
@export_group("stats")
@export var life:float
@export var energy:float
@export var attack:float
@export var defend:float
@export var speed:float#la speed tambien afecta al movimiento
@export var inteligent:float
@export var will:float
@export var fighter:float
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var IA_type:int

var direction:Vector2=Vector2.ZERO

func stats_set(ID:int):
	var keys=["Digimon_Id","digimon_name","life","energy","attack","defend","speed","inteligent","will","fighter","groud_move","water_move","air_move","IA_type"]
	var new_stats=Base.base[ID]
	var data_index=0
	while data_index>10:
		set(keys[data_index],new_stats[data_index])
	
