class_name DigimonBody extends CharacterBody2D
const ANIMATIONDIR:PackedStringArray=["down","left","leftdown","leftup","right","rightdown","rightup","up"]
const DIR_VECTOR:Array[Vector2i]=[Vector2i.DOWN,Vector2i.LEFT,Vector2i.LEFT+Vector2i.DOWN,Vector2i.LEFT+Vector2i.UP,Vector2i.RIGHT,Vector2i.RIGHT+Vector2i.DOWN,Vector2i.RIGHT+Vector2i.UP,Vector2i.UP]
#de ser necesario, estas 2 se volveran un solo diccionario
var previus_dir:Vector2i=Vector2i.DOWN

var dir:Vector2i=Vector2i.ZERO:
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
	$sprite/Name/VBoxContainer/e.set_mode()
	$sprite/Name/VBoxContainer/h.set_mode()
	$sprite/Name/VBoxContainer/l.set_mode()

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

func _get_inputs()->void:#tengo que hacegurarme que el vector sea de 1 entero para que si se usa joystick no se sume a 1.41
	@warning_ignore("narrowing_conversion")
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	@warning_ignore("narrowing_conversion")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

#func hurt():$hurt.play()
func hited()->void:
	$hurt.play()
	sprite.play("hit_"+sprite.animation.erase(0,4))

func dead_anim_and_queue_free():
	var frelear=[get_node_or_null("patas"),get_node_or_null("prepcion"),get_node_or_null("sprite/Name")]
	for i in frelear:if i:i.queue_free()
	if attribute==DigimonCORE.attribut.FR:sprite.material.shader=Resouses.FREE_DEAD
	else:
		sprite.material.shader=Resouses.DEAD
		match attribute:
			DigimonCORE.attribut.VI: sprite.modulate=Color(1,0,0)
			DigimonCORE.attribut.VA: sprite.modulate=Color(0,0,1)
			DigimonCORE.attribut.DA: sprite.modulate=Color(0,1,1)
			_: sprite.modulate=Color(0.14,0.14,0.14,1)
	sprite.material.set("shader_parameter/noise_tex_normal",Resouses.NOISE_NORMAL)
	sprite.material.set("shader_parameter/noise_tex",Resouses.NOISE)
	sprite.material.set("resource_local_to_scene",true)
	var tween=get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN)
	tween.tween_method(set_progress,0,2,0.5)
	#tween.tween_method(sprite.material.set_shader_parameter,0,2,0.3)
	tween.play()
	await tween.finished
	for body in enemies:if body:body.core.data+=int(get_life()/enemies.size()*2)
	if visual:visual.free()
	queue_free()

func set_progress(i:float):sprite.material.set("shader_parameter/progress",i)
func event(idx:int)->void: # 0=evadir. 1=block. 2=no morir
	var e=Resouses.DIGIMON_EVENTS[idx].instantiate()
	add_child(e)
func attack(acc:String):sprite.play(acc+"_"+sprite.animation.erase(0,4))

func _on_sprite_animation_finished()->void:#el sprite sheet debe tener primero los idel, luego el run y de ultimo el hit, de ahi los ataques de cualquier orden, mejor si es el que tienen en numero
	interaction_area.rotar(previus_dir)
	var new_anim:String=sprite.animation
	if dir==Vector2i.ZERO:# and impulse==Vector2.ZERO:
		if !sprite.animation.begins_with("d"):new_anim="del_"+new_anim.erase(0,4)
			#if sprite.animation!=new_anim:sprite.play(new_anim)
	else:new_anim="run_"+ANIMATIONDIR[DIR_VECTOR.find(previus_dir)]
	if sprite.animation!=new_anim:sprite.play(new_anim)
	#set_previus_dir_and_run_record()

func set_previus_dir_and_run_record(delta:float)->void:
	if dir !=Vector2i.ZERO:
		run_record+=delta
		if dir!=previus_dir:
			await get_tree().process_frame
			await get_tree().process_frame
			await get_tree().process_frame
			if dir!=previus_dir and dir !=Vector2i.ZERO:previus_dir=dir
