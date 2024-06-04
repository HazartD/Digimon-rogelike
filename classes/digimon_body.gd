class_name DigimonBody extends CharacterBody2D
const STATE:PackedScene=preload("res://other scene/digimon_estate.tscn")
var dir:Vector2=Vector2.ZERO:
	set(value):
		if !$sprite.animation.begins_with("h") and !$sprite.animation.begins_with("A"):_on_sprite_animation_finished()
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
const animationdir:PackedStringArray=["down","left","leftdown","leftup","right","rightdown","rightup","up"]
const dir_vector:PackedVector2Array=[Vector2.DOWN,Vector2.LEFT,Vector2.LEFT+Vector2.DOWN,Vector2.LEFT+Vector2.UP,Vector2.RIGHT,Vector2.RIGHT+Vector2.DOWN,Vector2.RIGHT+Vector2.UP,Vector2.UP]
@onready var interaction_area:Area2D=$interaction_area
@onready var sprite=$sprite
@onready var bar_l:TextureProgressBar=$sprite/Name/VBoxContainer/l
@onready var bar_e:TextureProgressBar=$sprite/Name/VBoxContainer/e
@onready var bar_h:TextureProgressBar=$sprite/Name/VBoxContainer/h
var _life:float
var _energy:float
var _attack:float
var _defend:float
var _speed:float
var _inteligent:float
var _will:float
var _fighter:float
func get_life()->float:return _life+(_life*core.life)
func get_fighter()->float:return _fighter+(_fighter*core.fighter)
func get_will()->float:return _will+(_will*core.will)
func get_inteligent()->float:return _inteligent+(_inteligent*core.inteligent)
func get_speed()->float:return _speed+(_speed*core.speed)
func get_defend()->float:return _defend+(_defend*core.defend)
func get_attack()->float:return _attack+(_attack*core.attack)
func get_energy()->float:return _energy+(_energy*core.energy)

func set_stats()->void:
	var keys=["Digimon_Id","digimon_name","_life","_energy","_attack","_defend","_speed","_inteligent","_will","_fighter"]
	var new_stats=Base.base[Digimon_Id]
	var data_index=0
	while data_index<10:
		set(keys[data_index],new_stats[data_index])
		data_index+=1
	core.max_hunger=new_stats[10]
	core.attribute=attribute
	core.Evo_level=Evo_level
	core.max_energy=get_energy()
	core.current_energy=get_energy()
	core.current_life=get_life()
	core.max_life=get_life()
	core.body=self
	if player==true:$sprite/Name.text=Iniload.player_name+"
	("+digimon_name+"mon)"
	else:$sprite/Name.text=digimon_name+"mon"

func _ready():
	hide()
	
	core=get_parent()
	sprite.play("del_down")
	set_stats()
	if $VisibleOnScreenNotifier2D:
		var v=$VisibleOnScreenNotifier2D
		remove_child(v)
		core.call_deferred("add_child",v)
		v.connect("screen_entered",func():show())
		v.connect("screen_exited",func():hide())
	
	#sprite.material.set_shader_parameter("progress",0.5)

#aqui no se si meter que el impulse sea un dir que fuerce una direccion o que solo afecte la velocidad
func _physics_process(delta):
	if player:_get_inputs()
	velocity=(((dir*impulse)*(10000+get_speed())))*delta
#	velocity=(((dir+impulse)*(10000+get_speed())))*delta
	move_and_slide()

func _get_inputs()->void:#dir = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
func hurt():$hurt.play()
func hited():
	hurt()
	if core.current_life<=0:
		var tween=get_tree().create_tween()
		tween.tween_property(sprite.material,"shader_parameter/progress",1,0.3)
		await tween.finished
		queue_free()
	else:sprite.play("hit_"+sprite.animation.erase(0,4))

func flee():
	var e=STATE.instantiate()
	add_child(e)
func attack(acc:String):
	var new_anim:String=acc+"_"+sprite.animation.erase(0,4)
	if sprite.sprite_frames.has_animation(new_anim):sprite.play(new_anim)

func _on_sprite_animation_finished():
	#await get_tree().process_frame
	#await get_tree().process_frame
	interaction_area.rotar(dir)
	var new_anim:String=sprite.animation
	if dir==Vector2.ZERO:# and impulse==Vector2.ZERO:
		if !sprite.animation.begins_with("d"):new_anim="del_"+new_anim.erase(0,4)
			#if sprite.animation!=new_anim:sprite.play(new_anim)
	else:new_anim="run_"+animationdir[dir_vector.find(interaction_area.previus_dir)]
	if sprite.animation!=new_anim:sprite.play(new_anim)
