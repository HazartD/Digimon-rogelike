class_name State extends Node
var controlled_node:Node
var state_machine:StateMachine
func end()->void:pass
func start()->void:pass
func on_process(_delta)->void:pass
func on_physics_process(_delta)->void:pass
func on_input(_event)->void:pass
#func on_unhandled_input(_event)->void:pass
#func on_unhandled_key_input(_event)->void:pass
