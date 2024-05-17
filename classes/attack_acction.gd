class_name AttackAction extends Attack
var physic:bool#si es fisico true y si intelig false
var reposo:float
@export var accion:String="A01"
var costo:int=10
@export var sound:Resource
@export var max_sound_distanse:int
func action():
	digimon_owner.attack(accion)
	reposo=kooldown
	effect()
	digimon_owner.core.current_energy-=costo
	$sound.play()

func _ready():
	$sound.stream=sound
	$sound.max_distance=max_sound_distanse

func effect():
	pass
func _process(delta):
	if reposo>0.0:
		reposo-=delta
func _input(event):
	if digimon_owner.player:
		if event.is_action(accion) and reposo<=0.0 and digimon_owner.core.current_energy>=costo:
			action()
	#hacer que en realidad el reposo dure menos unos 0.1 segundos menos de lo que tarda en dar feedback aniacion
