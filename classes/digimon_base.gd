class_name DigimonBase extends CharacterBody2D
enum IA_types {}
enum attribut{VA,DA,VI,FR,UNK}
enum level_evo{BABYI,BABYII,CHILD,ADULT,PERFECT,ULTIMATE}
@export_group("freatures")
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var IA_type:IA_types
@export var attribute:attribut
@export var Evo_level:level_evo
@export var Digimon_Id:int
@export var digimon_name:String

@export_group("stats_base")
@export var _life:int
@export var _energy:int
@export var _attack:int
@export var _defend:int
@export var _speed:int
@export var _inteligent:int
@export var _will:int

@export_group("stats")
@export var life:float=0.0:
	get:
		return _life+(life*_life)
@export var energy:float=0.0:
	get:
		return _energy+(energy*_energy)
@export var attack:float=0.0:
	get:
		return _attack+(attack*_attack)
@export var defend:float=0.0:
	get:
		return _defend+(defend*_defend)
@export var speed:float=0.0:#la speed tambien afecta al movimiento
	get:
		return _speed+(speed*_speed)
@export var inteligent:float=0.0:
	get:
		return _inteligent+(inteligent*_inteligent)
@export var will:float=0.0:
	get:
		return _will+(will*_will)
@export var fighter:float

func stats_set(ID:int):
	var keys=["Digimon_Id","digimon_name","_life","_energy","_attack","_defend","_speed","_inteligent","_will","fighter","groud_move","water_move","air_move","IA_type","attribute","Evo_level"]
	var new_stats=Base.base[ID]
	var data_index=0
	while data_index<15:
		set(keys[data_index],new_stats[data_index])
	$Name.text=digimon_name+"mon"#si llegara a añadir a uno que no lleve mon, pongo un if de si es de ese ID y su else donde si pone el mon
func set_sprite(path:String):
	$sprite.sprite_frames=load(path)
func _ready():
	set_sprite("res://img/animation_resouse/digimon_base.tres")

func _on_sprite_frames_changed():
	var tamaño=$sprite.sprite_frames.get_frame_texture($sprite.animation,0).get_size()
	$Name.position.y-=tamaño.y/2
	$patas.shape.size=tamaño
	$Name/AtackBar.size=$Name.size
	$Name/AtackBar.position.y-=$Name.size.y/2


