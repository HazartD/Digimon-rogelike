class_name AttackAction extends Attack
@export var acction:InputEventAction
@export_enum("rapid:1","low:3","medium:5","high:7") var kooldown=3
var physic:bool#si es fisico true y si intelig false
var reposo:float
var accion:String="A01"
var costo:int
signal accionado
var missile:PackedScene
func _process(delta):
	if reposo>=0.0:
		reposo-=delta
func _input(event):
	if event.is_action(accion) and reposo<=0.0:
		accionado.emit()
		reposo=kooldown
	#hacer que en realidad el reposo dure menos unos 0.1 segundos menos de lo que tarda en dar feedback aniacion
