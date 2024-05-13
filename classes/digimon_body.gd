class_name DigimonBody extends CharacterBody2D
var dir:Vector2=Vector2.ZERO
var digimon_name:String
var player:bool=true
var animation_dir:String="down"
var animation_state:String="idel"
@export_group("freatures")
@export var Digimon_Id:int
@export var air_move:bool
@export var groud_move:bool
@export var water_move:bool
@export var attribute:DigimonCORE.attribut
@export var Evo_level:DigimonCORE.level_evo
const animationdir:Array=["down","left","leftdown","leftup","right","rightdown","rightup","up"]
const dir_vector:Array[Vector2]=[Vector2.DOWN,Vector2.LEFT,Vector2.LEFT+Vector2.DOWN,Vector2.LEFT+Vector2.UP,Vector2.RIGHT,Vector2.RIGHT+Vector2.DOWN,Vector2.RIGHT+Vector2.UP,Vector2.UP]
var core:DigimonCORE=get_parent()

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
	while data_index<11:
		set(keys[data_index],new_stats[data_index])
	$Name.text=digimon_name+"mon"
	core.attribute=attribute
	core.Evo_level=Evo_level
	core.max_life=get_life()
	core.max_energy=get_energy()
	core.current_life=get_life()
	core.current_energy=get_energy()
	core.body=self

func _ready():
	$sprite.play("run_down")
	#set_stats()
	

func _physics_process(delta):
	if player:_get_inputs()
	velocity=dir*10000*delta
	move_and_slide()
	
func _get_inputs():
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")


func _on_visible_on_screen_notifier_2d_screen_exited():
	visible=false

func _on_visible_on_screen_notifier_2d_screen_entered():
	visible=true


func _on_sprite_animation_finished():
	var new_anim:String
	if dir==Vector2.ZERO:
		if !$sprite.animation.begins_with("d"):
			new_anim=$sprite.animation
			new_anim.erase(0,4)
			new_anim.insert(0,"del_")
			print(new_anim)
			#$sprite.play(new_anim)
		#if $sprite.animation.has(animationdir[0]) and !$sprite.animation.has(animationdir[2]) and !$sprite.animation.has(animationdir[5]):new_anim="idel_"+animationdir[0]
		#elif $sprite.animation.has(animationdir[1])and !$sprite.animation.has(animationdir[2]) and !$sprite.animation.has(animationdir[3]):new_anim="idel_"+animationdir[1]
		#elif $sprite.animation.has(animationdir[2]):new_anim="idel_"+animationdir[2]
		#elif $sprite.animation.has(animationdir[3]):new_anim="idel_"+animationdir[3]
		#elif $sprite.animation.has(animationdir[4])and !$sprite.animation.has(animationdir[5]) and !$sprite.animation.has(animationdir[6]):new_anim="idel_"+animationdir[4]
		#elif $sprite.animation.has(animationdir[5]):new_anim="idel_"+animationdir[5]
		#elif $sprite.animation.has(animationdir[6]):new_anim="idel_"+animationdir[6]
		#elif $sprite.animation.has(animationdir[7])and !$sprite.animation.has(animationdir[3]) and !$sprite.animation.has(animationdir[6]):new_anim="idel_"+animationdir[7]
	else:
		if dir==dir_vector[0]:new_anim="run_"+animationdir[0]
		elif dir==dir_vector[1]:new_anim="run_"+animationdir[1]
		elif dir==dir_vector[2]:new_anim="run_"+animationdir[2]
		elif dir==dir_vector[3]:new_anim="run_"+animationdir[3]
		elif dir==dir_vector[4]:new_anim="run_"+animationdir[4]
		elif dir==dir_vector[5]:new_anim="run_"+animationdir[5]
		elif dir==dir_vector[6]:new_anim="run_"+animationdir[6]
		elif dir==dir_vector[7]:new_anim="run_"+animationdir[7]
#	if $sprite.animation!=new_anim:$sprite.play(new_anim)

