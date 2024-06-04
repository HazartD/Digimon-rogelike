class_name DigimonCORE extends Node
enum attribut{VA,DA,VI,FR,UNK}
enum level_evo{BABYI,BABYII,CHILD,ADULT,PERFECT,ULTIMATE,ARMOR,UNKNOW,NOLEVEL}
#hace macth con el ide y
var time:float=0.0
var digimon_id:int
var body:DigimonBody
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
var current_life:float=10:
	set(v):
		current_life=v
		if current_life>max_life:current_life=max_life
var current_energy:float:
	set(v):
		current_energy=v
		if current_energy>max_energy:current_energy=max_energy
var current_hunger:float:
	set(v):
		current_hunger=v
		if current_hunger>max_hunger:current_hunger=max_hunger
var enemies:Array[DigimonCORE]=[]#if ese, y prosige, else: pop
	#set_sprite("res://img/animation_resouse/digimon_base.tres")

func hit(damage:float,dir:Vector2,a:DigimonBody,physic:bool,area:bool=false):
	if physic:a.core.attack+=0.01
	else:a.core.inteligent+=0.01
	var limit=(body.get_speed()-a.get_speed())
	if area or limit<=0:_hit(damage,dir,a.attribute,physic)
	else:
		if randi_range(0,limit/2)==0:_hit(damage,dir,a.attribute,physic)
		else:body.flee()
	#if enemies.has(a):
		#enemies.append(a)
	#else:enemies.append(a)
func _hit(damage:float,atta_dir:Vector2,attri:attribut,physic:bool):
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
func minus_life(damage:float,physic:bool,divisor:float=1):
	damage=(damage*divisor)
	if physic:damage-=(body.get_defend()*0.25)
	else :damage-=(body.get_inteligent()*0.25)
	current_life-=damage
	damage_recive+=damage
	defend+=damage/10000

func regen(delta:float):
	if current_energy<max_energy:current_energy+=delta/4
	if current_life<max_life:current_life+=delta/4
	current_hunger-=delta/4

func evo():pass
	#crea clase evolution
	#set_stats(seasch_evo(mete como parametro la id, los stas y si es el player))
	#machtea la id, mete las funciones en un array, por cada una la ejecuta y si da false la saca y de lo contrario regresa la id, cada funcion tiene el nombre del digi, comprueba cada stat importante, mete 

func _process(delta):
	regen(delta)
	current_hunger-=delta/4
	time+=delta
