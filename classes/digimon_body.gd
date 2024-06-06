class_name DigimonBody extends CharacterBody2D
const STATE:PackedScene=preload("res://other scene/digimon_estate.tscn")
const ANIMATIONDIR:PackedStringArray=["down","left","leftdown","leftup","right","rightdown","rightup","up"]
const DIR_VECTOR:PackedVector2Array=[Vector2.DOWN,Vector2.LEFT,Vector2.LEFT+Vector2.DOWN,Vector2.LEFT+Vector2.UP,Vector2.RIGHT,Vector2.RIGHT+Vector2.DOWN,Vector2.RIGHT+Vector2.UP,Vector2.UP]
#de ser necesario, estas 2 se volveran un solo diccionario
var previus_dir:Vector2=Vector2.DOWN

var dir:Vector2=Vector2.ZERO:
	set(value):
		if !sprite.animation.begins_with("h") and !sprite.animation.begins_with("A"):_on_sprite_animation_finished()

var run_record:float=0:#si al final no se necesita tener el recor de tiempo que se ha corrido, cambio el % por >= y descomento la ultima linea
	set(v):
		run_record=v
		if int(run_record)%1000==0:
			core.speed+=0.01
			#run_record=0

var enemies:Array[DigimonBody]=[]
var digimon_name:String
var player:bool=false
var core:DigimonCORE=get_parent()
var impulse:int=1#Vector2=Vector2.ZERO

@export_group("freatures")
@export var Digimon_Id:int
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var attribute:DigimonCORE.attribut
@export var Evo_level:DigimonCORE.level_evo


var _life:float
var _energy:float
var _attack:float
var _defend:float
var _speed:float
var _inteligent:float
var _will:float
var _fighter:float
func get_life()->float:return _life+(_life*core.life)
func get_energy()->float:return _energy+(_energy*core.energy)
func get_fighter()->float:return _fighter+(_fighter*core.fighter)
func get_will()->float:return _will+(_will*core.will)
func get_inteligent()->float:return _inteligent+(_inteligent*core.inteligent)
func get_speed()->float:return _speed+(_speed*core.speed)
func get_defend()->float:return _defend+(_defend*core.defend)
func get_attack()->float:return _attack+(_attack*core.attack)


@onready var interaction_area:Area2D=$interaction_area
@onready var sprite=$sprite
@onready var visual=$VisibleOnScreenNotifier2D

func set_stats()->void:
	var keys=["Digimon_Id","digimon_name","_life","_energy","_attack","_defend","_speed","_inteligent","_will","_fighter"]
	var new_stats=Base.base[Digimon_Id]
	var data_index=0
	while data_index<10:
		set(keys[data_index],new_stats[data_index])
		data_index+=1
	core.max_hunger=new_stats[10]
	core.max_life=get_life()
	core.max_energy=get_energy()
	core.attribute=attribute
	core.Evo_level=Evo_level
	core.body=self
	if player:$sprite/Name.text=Iniload.player_name+"
	("+digimon_name+"mon)"
	else:$sprite/Name.text=digimon_name+"mon"
	$sprite/Name/VBoxContainer/e._ready()
	$sprite/Name/VBoxContainer/h._ready()
	$sprite/Name/VBoxContainer/l._ready()

func _ready()->void:
	hide()
	core=get_parent()
	sprite.play("del_down")
	set_stats()
	if visual:
		remove_child(visual)
		core.call_deferred("add_child",visual)
		visual.connect("screen_entered",show)
		visual.connect("screen_exited",hide)


#aqui no se si meter que el impulse sea un dir que fuerce una direccion o que solo afecte la velocidad
func _physics_process(delta)->void:
	if player:_get_inputs()
	velocity=(((dir*impulse)*(10000+get_speed())))*delta
	set_previus_dir_and_run_record(delta)
	move_and_slide()
#	velocity=(((dir+impulse)*(10000+get_speed())))*delta

func _get_inputs()->void:
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

#func hurt():$hurt.play()
func hited()->void:
	$hurt.play()
	if core.current_life<=0:
		if visual:visual.queue_free()
		var tween=get_tree().create_tween()#cambiar color con el self_modulate
		tween.tween_property(sprite.material,"shader_parameter/progress",1,0.3)
		await tween.finished
		for body in enemies:if body:body.core.data+=int(get_life()/enemies.size()*2)
		queue_free()
	else:sprite.play("hit_"+sprite.animation.erase(0,4))
func flee()->void:
	var e=STATE.instantiate()
	add_child(e)
func block()->void:
	var e=STATE.instantiate()
	e.text="BLK"
	add_child(e)
func no_dead():
	var e=STATE.instantiate()
	e.text="NOD"
	add_child(e)
func attack(acc:String):#cuando haga las animaciones de embest quitare el if y lo dejare en una sola linea
	var new_anim:String=acc+"_"+sprite.animation.erase(0,4)
	if sprite.sprite_frames.has_animation(new_anim):sprite.play(new_anim)

func _on_sprite_animation_finished()->void:
	interaction_area.rotar(previus_dir)
	var new_anim:String=sprite.animation
	if dir==Vector2.ZERO:# and impulse==Vector2.ZERO:
		if !sprite.animation.begins_with("d"):new_anim="del_"+new_anim.erase(0,4)
			#if sprite.animation!=new_anim:sprite.play(new_anim)
	else:new_anim="run_"+ANIMATIONDIR[DIR_VECTOR.find(previus_dir)]
	if sprite.animation!=new_anim:sprite.play(new_anim)
	#set_previus_dir_and_run_record()

func set_previus_dir_and_run_record(delta:float)->void:
	if dir !=Vector2.ZERO:
		run_record+=delta
		if dir!=previus_dir:
			await get_tree().process_frame
			await get_tree().process_frame
			await get_tree().process_frame
			if dir!=previus_dir and dir !=Vector2.ZERO:previus_dir=dir
