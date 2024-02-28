class_name AttackAction extends Attack
@export var acction:InputEventAction
var physic:bool#si es fisico true y si intelig false
var reposo:float
var accion:String="A1"
var costo:int
signal accionado
var missile:PackedScene
@onready var atribure:DigimonBody.attribut=digimon_owner.attribute
func _input(event):
	if event.is_action(accion): accionado.emit()

