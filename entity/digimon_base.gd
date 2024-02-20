class_name DigimonBase extends CharacterBody2D
const BASE_SPEED=10000
@export var _Digimon_Id:int
@export var digimon_name:String
@export_group("stats")
@export var _life:float=100.0
@export var _energy:float=120.0
@export var _attack:float=102.0
@export var _defend:float=102.0
@export var _speed:float=102.0#la speed tambien afecta al movimiento
@export var _inteligent:float=210.0
@export var _will:float=102.0
@export var _fighter:float

var direction:Vector2=Vector2.ZERO

func stats_set():
	pass
