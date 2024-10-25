class_name DigimonCORE extends Node
enum attribut{VA,DA,VI,FR,UNK}
enum level_evo{BABYI,BABYII,CHILD,ADULT,PERFECT,ULTIMATE,ARMOR,UNKNOW,NOLEVEL}
signal life_changed(new)
signal energy_changed(new)
signal hunger_changed(new)
#hace macth con el ide y
var time:float=0.0
var digimon_id:int
var body:DigimonBody
var step:int=1#generacion
var birth_locations:Array[Base.LOCATIONS]=[]
#region stats y asi
@onready var state_machine:StateMachineDigimon
@export var attribute:attribut
@export var Evo_level:level_evo
@export_group("stats")
@export var life:float=0.1
@export var energy:float=0.1
@export var attack:float=0.1
@export var defend:float=0.1
@export var speed:float=0.1
@export var inteligent:float=0.1
@export var will:float=0.01
@export var fighter:float=0.1
@export var damage_recive:float=0.0
var max_life:float=10:
	set(v):
		max_life=v
		current_life=v
var max_energy:float:
	set(v):
		max_energy=v
		current_energy=v
var max_hunger:int:
	set(v):
		max_hunger=v
		current_hunger=v
var current_life:float=0:
	set(v):
		current_life=v
		if current_life<=0:
			if Calculator.probability_with_division(1,body.get_will()*0.1,100):#deberias tener 1000 de will para que sea un 50/50#randf()<=0.01+body.get_will()*0.01:
				current_life=1
				will+=5
				body.event(2)
			else:state_machine.diying()
		emit_signal("life_changed",current_life)
var current_energy:float=0:
	set(v):
		current_energy=v
		if current_energy>max_energy:current_energy=max_energy
		if current_energy<=0:current_energy=0
		emit_signal("energy_changed",current_energy)
var current_hunger:float=0:
	set(v):
		current_hunger=v
		if current_hunger>max_hunger:current_hunger=max_hunger
		if current_hunger<=0:current_hunger=0
		emit_signal("hunger_changed",current_hunger)
	#set_sprite("res://img/animation_resouse/digimon_base.tres")
var data:int=0:
	set(v):
		data=v
		current_hunger+=float(v)/2
#endregion

#func ded(a:DigimonBody)->void:pass
func _ready()->void:
	var _time=get_tree().create_timer(3).timeout.connect(regen)
	
	for i in get_children():if i is StateMachine:state_machine=i

func effectiviry(attri:attribut)->float:
	if attribute==attribut.VA:match attri:
		attribut.VI:return Calculator.EFECTIVE_ATTACK_MULTIPLICATOR_NOT
		attribut.DA:return Calculator.EFECTIVE_ATTACK_MULTIPLICATOR
	elif attribute==attribut.VI:match attri:
		attribut.VA:return Calculator.EFECTIVE_ATTACK_MULTIPLICATOR
		attribut.DA:return Calculator.EFECTIVE_ATTACK_MULTIPLICATOR_NOT
	else:match attri:
		attribut.VA:return Calculator.EFECTIVE_ATTACK_MULTIPLICATOR_NOT
		attribut.VI:return Calculator.EFECTIVE_ATTACK_MULTIPLICATOR
	return 1

func hit(damage:float,dir:Vector2,a:DigimonBody,physic:bool,area:bool=false)->void:
	if area:minus_life(damage,physic,effectiviry(a.attribute))
	else:# poner en tutorial "la practica hace al maestro"
		if physic:a.core.attack+=Calculator.TRAINING_STAT
		else:a.core.inteligent+=Calculator.TRAINING_STAT
		if Calculator.probability_with_division(body.get_speed(),a.get_speed()):
			if Calculator.probability_with_division(body.get_speed(),a.get_speed(),1.5):minus_life(damage,physic,effectiviry(a.attribute))
			else:
				minus_life(damage-Calculator.average_2(body.get_defend(),body.get_inteligent())*0.5,physic,effectiviry(a.attribute))
				defend+=Calculator.TRAINING_STAT
				body.event(1)
		else:
			speed+=Calculator.TRAINING_STAT
			body.event(0)
	body.enemies.push_back(a)
	body.position+=dir*Calculator.knockback(damage,life)
	#ded(a)

func minus_life(damage:float,physic:bool,multiplicator:float)->void:
	damage=Calculator.damage(damage,body.get_defend(),multiplicator) if physic else Calculator.damage(damage,body.get_inteligent(),multiplicator)
	current_life-=damage
	damage_recive+=damage
	defend+=Calculator.more_defend(damage)

func regen()->void:
	current_hunger-=1
	if current_hunger>=float(max_hunger)/2:
		if current_energy<max_energy:current_energy+=2
		if current_life<max_life and current_life>0 :current_life+=2
	var _time=get_tree().create_timer(3).timeout.connect(regen)

func to_tama()->void:
	var a=Iniload.location
	birth_locations.push_back(a)
	var tama=Resouses.TAMA.instantiate()
	add_child(tama)
	tama.position=body.position
	if [Base.LOCATIONS.DS,Base.LOCATIONS.SHORE].has(a):tama.sprite.frame_coords.y=0
	elif [Base.LOCATIONS.DR].has(a):tama.sprite.frame_coords.y=1
	elif [Base.LOCATIONS.JT].has(a):tama.sprite.frame_coords.y=2
	elif [Base.LOCATIONS.ME,Base.LOCATIONS.CRACK_TEAM_BASE].has(a):tama.sprite.frame_coords.y=3
	elif [Base.LOCATIONS.NSP,Base.LOCATIONS.FILE_CITY].has(a):tama.sprite.frame_coords.y=4
	elif [Base.LOCATIONS.NSO].has(a):tama.sprite.frame_coords.y=5
	elif [Base.LOCATIONS.VB].has(a):tama.sprite.frame_coords.y=6
	elif [Base.LOCATIONS.WG].has(a):tama.sprite.frame_coords.y=7
	else:tama.sprite.frame_coords.y=8#Unkown

func _process(delta)->void:
	time+=delta
