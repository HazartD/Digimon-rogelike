class_name AttackAction extends Attack
@export var accion:String="A01"
@export var costo:int=10
@export var sound:Resource
@export var max_sound_distanse:int=500
func action()->void:
	digimon_owner.attack(accion)
	await digimon_owner.sprite.frame_changed
	reposo=kooldown
	digimon_owner.core.current_energy-=costo
	$sound.play()
	effect()
func _ready()->void:
	$sound.stream=sound
	$sound.max_distance=max_sound_distanse
	await get_tree().create_timer(0.2).timeout
	powered()
func effect()->void:
	pass

# si quito "and !digimon_owner.sprite.animation.begins_with("A")" se pueden presionar 2 a la vez y se activan ambos.
#Si los vas alternando rapido, al final cuando no asertes el timing o lo dejes disparar, se activaran funciones por cada clic que diste aunque no alcanzaran con la energia que tienes.
#de modo que si lo logras hacer por mucho tiempo, haces un ataque ultra fuerte que puede gastar mas energia que la que tienes sin dejar de ser efectivo
func _input(event)->void:
	if digimon_owner.player:
		if event.is_action_pressed(accion) and !digimon_owner.sprite.animation.begins_with("A"):if reposo<=0.0 and digimon_owner.core.current_energy>=costo:action()
	#hacer que en realidad el reposo dure menos unos 0.1 segundos menos de lo que tarda en dar feedback aniacion
