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
var generatiom:int=1
var birth_locations:Array[Base.LOCATIONS]=[]
@export var attribute:attribut
@export var Evo_level:level_evo
@export_group("stats")
@export var life:float=0.1
@export var energy:float=0.1
@export var attack:float=0.1
@export var defend:float=0.1
@export var speed:float=0.1
@export var inteligent:float=0.1
@export var will:float=0.1
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
			if randf()<=0.01+body.get_will()*0.01:
				current_life=1
				will+=5
				body.event(2)
			else:body.dead_anim_and_queue_free()
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
#func ded(a:DigimonBody)->void:pass
func _ready()->void:
	var _time=get_tree().create_timer(3).timeout.connect(regen)

func hit(damage:float,dir:Vector2,a:DigimonBody,physic:bool,area:bool=false)->void:
	body.enemies.push_back(a)
	if area:_hit(damage,dir,a.attribute,physic)
	else:
		var self_speed=body.get_speed()
		var ataker_speed=a.get_speed()
		if physic:a.core.attack+=0.01
		else:a.core.inteligent+=0.01
		var limit=(ataker_speed/(self_speed+ataker_speed))/3
		var rng=randf()
		if limit<=rng:
			#_hit(damage,dir,a.attribute,physic)
			if limit*1.5<=rng:_hit(damage,dir,a.attribute,physic)
			else:
				_hit(damage-body.get_defend()*0.5,dir,a.attribute,physic)
				defend+=0.01
				body.event(1)
		else:
			speed+=0.1/limit
			body.event(0)
	#ded(a)

func _hit(damage:float,atta_dir:Vector2,attri:attribut,physic:bool)->void:
	var knockback=damage-(life/8)
	if knockback>0:body.position+=atta_dir*(knockback/2)
	if attribute==attribut.FR or attribute==attribut.UNK:minus_life(damage,physic)
	elif attribute==attribut.VA:
		match attri:
			attribut.VI:minus_life(damage,physic,0.7)
			attribut.DA:minus_life(damage,physic,1.3)
			_:minus_life(damage,physic)
	elif attribute==attribut.VI:
		match attri:
			attribut.VA:minus_life(damage,physic,1.3)
			attribut.DA:minus_life(damage,physic,0.7)
			_:minus_life(damage,physic)
	else:
		match attri:
			attribut.VA:minus_life(damage,physic,0.7)
			attribut.VI:minus_life(damage,physic,1.3)
			_:minus_life(damage,physic)
	body.hited()
func minus_life(damage:float,physic:bool,divisor:float=1)->void:
	damage*=divisor
	if physic:damage-=(body.get_defend()*0.25)
	else :damage-=(body.get_inteligent()*0.25)
	current_life-=damage
	damage_recive+=damage
	defend+=damage/100000

func regen()->void:
	current_hunger-=1
	if current_hunger>=float(max_hunger)/2:
		if current_energy<max_energy:current_energy+=2
		if current_life<max_life and current_life>0 :current_life+=2
	var _time=get_tree().create_timer(3).timeout.connect(regen)

func evo()->void:
	pass
	#crea clase evolution
	#set_stats(seasch_evo(mete como parametro la id, los stas y si es el player))
	#machtea la id, mete las funciones en un array, por cada una la ejecuta y si da false la saca y de lo contrario regresa la id, cada funcion tiene el nombre del digi, comprueba cada stat importante, mete 
#func to_tama():
	#body.get_defend()
	#body.get_life()

func _process(delta)->void:
	time+=delta
