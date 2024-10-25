class_name DigimonBody extends CharacterBody2D
const DIR_ANIMARTION:PackedStringArray=["down","left","leftdown","leftup","right","rightdown","rightup","up"]
const DIR_VECTOR:Array[Vector2i]=[Vector2i.DOWN,Vector2i.LEFT,Vector2i.LEFT+Vector2i.DOWN,Vector2i.LEFT+Vector2i.UP,Vector2i.RIGHT,Vector2i.RIGHT+Vector2i.DOWN,Vector2i.RIGHT+Vector2i.UP,Vector2i.UP]
#de ser necesario, estas 2 se volveran un solo diccionario
var previus_dir:Vector2i=Vector2i.DOWN

var dir:Vector2i=Vector2i.ZERO:
	set(value):
		if !sprite.animation.begins_with("h") and !sprite.animation.begins_with("A"):_on_sprite_animation_finished()
		dir=value

var run_record:float=0:#si al final no se necesita tener el recor de tiempo que se ha corrido, cambio el % por >= y descomento la ultima linea
	set(v):
		run_record=v
		if int(run_record)%100==0:core.speed+=Calculator.TRAINING_STAT
			#run_record=0

var enemies:Array[DigimonBody]=[]
var digimon_name:String
var core:DigimonCORE=get_parent()
var impulse:int=1#Vector2=Vector2.ZERO
#region stats
var accions:Dictionary={}
@export_group("freatures")
@export var Digimon_Id:int
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var attribute:DigimonCORE.attribut
@export var Evo_level:DigimonCORE.level_evo
var _life:int
var _energy:int
var _attack:int
var _defend:int
var _speed:int
var _inteligent:int
var _will:int
var _fighter:int
func get_life()->float:return _life+(_life*core.life)
func get_energy()->float:return _energy+(_energy*core.energy)
func get_fighter()->float:return _fighter+(_fighter*core.fighter)
func get_will()->float:return _will+(_will*core.will)
func get_inteligent()->float:return _inteligent+(_inteligent*core.inteligent)
func get_speed()->float:return _speed+(_speed*core.speed)
func get_defend()->float:return _defend+(_defend*core.defend)
func get_attack()->float:return _attack+(_attack*core.attack)
#endregion
@onready var interaction_area:Area2D=$interaction_area
@onready var sprite=$sprite
@onready var visual=$VisibleOnScreenNotifier2D
@onready var hurt=$hurt

func _ready()->void:
	core=get_parent()
	hide()
	sprite.play("del_down")
	set_stats()
	visual.body=self
	if visual:
		remove_child(visual)
		core.call_deferred("add_child",visual)
		visual.connect("screen_entered",show)
		visual.connect("screen_exited",hide)

func set_stats()->void:
	var keys=["Digimon_Id","digimon_name","_life","_energy","_attack","_defend","_speed","_inteligent","_will","_fighter"]
	var new_stats=Base.base[Digimon_Id]
	#var data_index=0
	for index in new_stats.size()-1:
		set(keys[index],new_stats[index])
		#data_index+=1
	core.max_hunger=new_stats[10]
	core.max_life=get_life()
	core.max_energy=get_energy()
	core.attribute=attribute
	core.Evo_level=Evo_level
	core.body=self
	if core is Player:$sprite/Name.text=Iniload.player_name+"
	("+digimon_name+"mon)"
	else:$sprite/Name.text=digimon_name+"mon"
	$sprite/Name/VBoxContainer/e.set_mode()
	$sprite/Name/VBoxContainer/h.set_mode()
	$sprite/Name/VBoxContainer/l.set_mode()

#aqui no se si meter que el impulse sea un dir que fuerce una direccion o que solo afecte la velocidad
func _physics_process(delta)->void:
	velocity=Calculator.movement_speed(dir,get_speed(),delta,impulse)#vere si lo cambio no meter dir y que multiplique#((dir*impulse)*(10000+get_speed()))*delta#
	set_previus_dir_and_run_record(delta)
	move_and_slide()

func event(idx:int)->void: # 0=evadir. 1=block. 2=no morir
	var e=Resouses.DIGIMON_EVENTS[idx].instantiate()
	add_child(e)
func attack(acc:String):sprite.play(acc+"_"+sprite.animation.erase(0,4))

func _on_sprite_animation_finished()->void:#el sprite sheet debe tener primero los idel, luego el run y de ultimo el hit, de ahi los ataques de cualquier orden, mejor si es el que tienen en numero
	#deberia comprobar si esta ZERO primero
	interaction_area.rotar(previus_dir)
	var new_anim:String=sprite.animation
	if dir==Vector2i.ZERO:# and impulse==Vector2.ZERO:
		if !new_anim.begins_with("d"):new_anim="del_"+new_anim.erase(0,4)
			#if sprite.animation!=new_anim:sprite.play(new_anim)
	else:new_anim="run_"+DIR_ANIMARTION[DIR_VECTOR.find(previus_dir)]
	if sprite.animation!=new_anim:sprite.play(new_anim)
	#set_previus_dir_and_run_record()

func set_previus_dir_and_run_record(delta:float)->void:
	if dir!=Vector2i.ZERO:
		run_record+=delta
		if dir!=previus_dir:
			await get_tree().process_frame
			await get_tree().process_frame
			await get_tree().process_frame
			if dir!=previus_dir and dir !=Vector2i.ZERO:previus_dir=dir
