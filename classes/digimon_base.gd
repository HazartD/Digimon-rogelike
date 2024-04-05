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
@export var life:float=0.0
@export var energy:float=0.0
@export var attack:float=0.0
@export var defend:float=0.0
@export var speed:float=0.0#la speed tambien afecta al movimiento
@export var inteligent:float=0.0
@export var will:float=0.0
@export var fighter:float
@export var damage_recive:float=0.0

var max_life:float=10
var max_energy:float
var current_life:float=10
var current_energy:float
var enemies:Array[DigimonCORE]=[]#if ese, y prosige, else: pop

	#set_sprite("res://img/animation_resouse/digimon_base.tres")

func hit(damage:float,dir:Vector2,a:DigimonCORE):
	_hit(damage,dir)
	if enemies.has(a):
		enemies.pop_at(enemies.bsearch(a))
		enemies.append(a)
	else:enemies.append(a)

func _hit(damage:float,atta_dir:Vector2):
	var knockback=damage#-(life/5)#if menor a 0 no hay
	current_life-=damage
	damage_recive+=damage
	if current_life<=0:
		pass
	else: 
		if knockback>0:
			body.velocity+=atta_dir*(knockback*100)
		#$sprite.modulate=Color(0,0,0)
		#$sprite.pause()
		#await get_tree().create_timer(0.2).timeout
		#$sprite.modulate=Color(1,1,1,1)
		#$sprite.play()

func evo():
	pass
	#crea clase evolution
	#set_stats(seasch_evo(mete como parametro la id, los stas y si es el player))
	#machtea la id, mete las funciones en un array, por cada una la ejecuta y si da false la saca y de lo contrario regresa la id, cada funcion tiene el nombre del digi, comprueba cada stat importante, mete 


