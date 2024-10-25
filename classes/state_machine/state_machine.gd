class_name StateMachine extends Node
const STATE_METHODS:Dictionary={"process":"on_process","physics":"on_physics_process","in":"on_input","unhand":"on_unhandled_input","key":"on_unhandled_key_input"}
@onready var controlled_node:Node=get_parent()
@export var default_state:NodePath#String
var current_state:State
func _ready()->void:call_deferred("change_state",default_state)#change_state(default_state)

func change_state(next:String)->void:#esto podria tener otro argumento que por defecto sea null, y que lo reciba la funcion start(tambien con su argumento por defecto null) por caso de los ataques y asi
	if current_state:current_state.end()
	current_state=get_node(next)
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()
	state_name_comprobation(next)
	prints("StateMachine:",name,"/ control:",controlled_node.name, "/ start state:", current_state.name)
func state_name_comprobation(_name:String)->void:pass
func _input(event)->void:if current_state and current_state.has_method(STATE_METHODS.in):current_state.on_input(event)
func _process(delta)->void:if current_state and current_state.has_method(STATE_METHODS.process):current_state.on_process(delta)
func _physics_process(delta)->void:if current_state and current_state.has_method(STATE_METHODS.physics):current_state.on_physics_process(delta)
#func _unhandled_input(event)->void:if current_state and current_state.has_method(STATE_METHODS.unhand):current_state.on_unhandled_input(event)
#func _unhandled_key_input(event)->void:if current_state and current_state.has_method(STATE_METHODS.key):current_state.on_unhandled_key_input(event)
