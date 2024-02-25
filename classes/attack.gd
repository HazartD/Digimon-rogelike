class_name Attack extends Node
var power:float
var reposo:float
var costo:float
var accion:String
signal accionado
func _input(event):
	if event.is_action(accion): accionado.emit()
