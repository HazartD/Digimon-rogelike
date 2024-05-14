class_name DigimonBody extends CharacterBody2D
var dir:Vector2=Vector2.ZERO:
	set(value):
		_on_sprite_animation_finished()
		dir=value
var digimon_name:String
var player:bool=true
@export var core:DigimonCORE=get_parent()
@export_group("freatures")
@export var Digimon_Id:int
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var attribute:DigimonCORE.attribut
@export var Evo_level:DigimonCORE.level_evo
const animationdir:Array=["down","left","leftdown","leftup","right","rightdown","rightup","up"]
const dir_vector:Array[Vector2]=[Vector2.DOWN,Vector2.LEFT,Vector2.LEFT+Vector2.DOWN,Vector2.LEFT+Vector2.UP,Vector2.RIGHT,Vector2.RIGHT+Vector2.DOWN,Vector2.RIGHT+Vector2.UP,Vector2.UP]

var _life:float
var _energy:float
var _attack:float
var _defend:float
var _speed:float
var _inteligent:float
var _will:float
var _fighter:float
func get_life():
	return _life+(_life*core.life)
func get_fighter():
	return _fighter+(_fighter*core.fighter)
func get_will():
	return _will+(_will*core.will)
func get_inteligent():
	return _inteligent+(_inteligent*core.inteligent)
func get_speed():
	return _speed+(_speed*core.speed)
func get_defend():
	return _defend+(_defend*core.defend)
func get_attack():
	return _attack+(_attack*core.attack)
func get_energy():
	return _energy+(_energy*core.energy)

func set_stats():
	var keys=["Digimon_Id","digimon_name","_life","_energy","_attack","_defend","_speed","_inteligent","_will","_fighter"]
	var new_stats=Base.base[Digimon_Id]
	var data_index=0
	while data_index<10:
		set(keys[data_index],new_stats[data_index])
		data_index+=1
	#if player==true and core is Player:$sprite/Name.text=core.player_name
	#else:$sprite/Name.text=digimon_name+"mon"
	core.attribute=attribute
	core.Evo_level=Evo_level
	core.max_energy=get_energy()
	core.current_life=get_life()
	core.current_energy=get_energy()
	core.max_life=get_life()
	core.body=self

func _ready():
	core=get_parent()
	$sprite.play("del_down")
	set_stats()
	

func _physics_process(delta):
	if player:_get_inputs()
	velocity=dir*10000*delta
	move_and_slide()
	$sprite/Name.text=str(core.current_life)
func _get_inputs():
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")


func _on_visible_on_screen_notifier_2d_screen_exited():
	visible=false

func _on_visible_on_screen_notifier_2d_screen_entered():
	visible=true

func hited():
	if core.current_life<=0:pass
	else:
		var new_anim:String=$sprite.animation
		new_anim=new_anim.erase(0,4)
		new_anim=new_anim.insert(0,"hit_")
		$sprite.play(new_anim)
func attack(acc:String):
	var new_anim:String=$sprite.animation
	new_anim=new_anim.erase(0,4)
	new_anim=new_anim.insert(0,"_")
	new_anim=new_anim.insert(0,acc)
	$sprite.play(new_anim)


func _on_sprite_animation_finished():
	var new_anim:String=$sprite.animation
	if dir==Vector2.ZERO:
		if !$sprite.animation.begins_with("d"):
			new_anim=new_anim.erase(0,4)
			new_anim=new_anim.insert(0,"del_")
			if $sprite.animation!=new_anim:$sprite.play(new_anim)
	else:
		new_anim="run_"+animationdir[dir_vector.find(dir)]
		if $sprite.animation!=new_anim:$sprite.play(new_anim)
#	if $sprite.animation!=new_anim:$sprite.play(new_anim)

