class_name AttackAction extends Attack
@export var accion:String="A01"
@export var costo:int=10
@export var sound:Resource
@export var max_sound_distanse:int=500
func action():
	digimon_owner.attack(accion)
	reposo=kooldown
	digimon_owner.core.current_energy-=costo
	$sound.play()
	await digimon_owner.sprite.frame_changed
	effect()
func _ready():
	$sound.stream=sound
	$sound.max_distance=max_sound_distanse
	await get_tree().create_timer(0.2).timeout
	powered()
func effect():
	pass

func _input(event):
	if digimon_owner.player:
		if event.is_action_pressed(accion) and reposo<=0.0 and digimon_owner.core.current_energy>=costo:action()
	#hacer que en realidad el reposo dure menos unos 0.1 segundos menos de lo que tarda en dar feedback aniacion
