class_name AttackAction extends Attack
var physic:bool#si es fisico true y si intelig false
var reposo:float
@export var accion:String="A01"
var costo:int
var missile:PackedScene
func _process(delta):
	if reposo>=0.0:
		reposo-=delta
func _input(event):
	if digimon_owner.player:
		if event.is_action(accion) and reposo<=0.0:
			reposo=kooldown
			digimon_owner.attack(accion)
	#hacer que en realidad el reposo dure menos unos 0.1 segundos menos de lo que tarda en dar feedback aniacion
