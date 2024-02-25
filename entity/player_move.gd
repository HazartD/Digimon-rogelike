extends CharacterBody2D
var input_vector:Vector2=Vector2.ZERO
const SPEEDMOVE=9000
func _physics_process(delta):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	#gracias a xXtumbaBurrasXx del discord de godot por la idea
	velocity=input_vector*SPEEDMOVE*delta
	move_and_slide()
