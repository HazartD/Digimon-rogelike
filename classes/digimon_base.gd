class_name DigimonCORE extends Node
#hace macth con el ide y
var time:float=0.0
var direction:Vector2=Vector2.ZERO
var digimon_id:int
@onready var body:DigimonBody=$body
@export_group("stats")
@export var life:float=10.0
@export var energy:float=0.0
@export var attack:float=0.0
@export var defend:float=0.0
@export var speed:float=0.0#la speed tambien afecta al movimiento
@export var inteligent:float=0.0
@export var will:float=0.0
@export var fighter:float

var current_life:float=10
var current_energy:float
var enemies:Array[DigimonCORE]=[]#if ese, y prosige, else: pop

func stats_set(ID:int):
	digimon_id=ID
	#si llegara a añadir a uno que no lleve mon, pongo un if de si es de ese ID y su else donde si pone el mon
	current_life=life
func set_sprite(path:String):
	$sprite.sprite_frames=load(path)
func _ready():
	await get_tree().create_timer(4).timeout
	_hit(9,Vector2(1,1))
	#set_sprite("res://img/animation_resouse/digimon_base.tres")

func _on_sprite_frames_changed():
	var tamaño=$sprite.sprite_frames.get_frame_texture($sprite.animation,0).get_size()
	$Name.position.y-=tamaño.y/2
	$patas.shape.size=tamaño
	$Name/AtackBar.size=$Name.size
	$Name/AtackBar.position.y-=$Name.size.y/2

func hit(damage:float,dir:Vector2,a:DigimonCORE):
	_hit(damage,dir)
	if enemies.has(a):
		enemies.pop_at(enemies.bsearch(a))
		enemies.append(a)
	else:enemies.append(a)

func _hit(damage:float,atta_dir:Vector2):
	var knockback=damage#-(life/5)#if menor a 0 no hay
	current_life-=damage
	if current_life<=0:
		dead_animation()
	else: 
		if knockback>0:
			body.velocity+=atta_dir*(knockback*100)
		$sprite.modulate=Color(0,0,0)
		$sprite.pause()
		await get_tree().create_timer(0.2).timeout
		$sprite.modulate=Color(1,1,1,1)
		$sprite.play()

func evo():
	pass
	#crea clase evolution
	#set_stats(seasch_evo(mete como parametro la id, los stas y si es el player))
	
func dead_animation():
	var t=get_tree().create_tween()
	t.tween_property($sprite.material,"shader_parameter/progress",1,0.5)
	await t.finished


