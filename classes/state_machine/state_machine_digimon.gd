class_name StateMachineDigimon extends StateMachine
var special:bool
func state_name_comprobation(_name:String)->void:special = true if _name=="Diying" or _name=="Evolving" else false
func hitted(damage:float,dir:Vector2,a:DigimonBody,physic:bool,area:bool=false)->void:
	if special:return
	get_node("Hitted").last_state=current_state.last_state if current_state.name=="Hitted" else current_state.name
	change_state("Hitted")
	controlled_node.hit(damage,dir,a,physic,area)
func diying()->void:if !special:change_state("Diying")
