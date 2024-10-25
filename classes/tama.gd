class_name DigimonTama extends RigidBody2D
@onready var sprite:Sprite2D=$Sprite2D
func set_progress(i:float):sprite.material.set("shader_parameter/progress",i)
#func _ready()->void:
	#get_tree().create_timer(30).timeout.connect(hatch)
func hatch()->void:
	var tween=get_tree().create_tween().set_loops(5)
	tween.tween_property(sprite,"scale:y",0.7,0.3)
	tween.chain().tween_property(sprite,"scale:y",1,0.3)
	await tween.finished
	var tween2=get_tree().create_tween()
	tween2.tween_method(set_progress,0,2,1)
func hitted(steps:int=1)->void:
	if sprite.frame_coords.x+steps>=5:queue_free()#a ver luego cuanto aguante le hago
	else:sprite.frame_coords.x+=steps
func _on_body_entered(body)->void:
	var impact
	match body.get_class():
		"StaticItem":impact=linear_velocity.length() * mass * body.hardness
		"RigidBody2D":impact=(body.linear_velocity-linear_velocity).length()*body.mass
		"CharacterBody2D":impact=(body.velocity-linear_velocity).length()
	print("impact: ",impact)
	if impact>1500:hitted(5)
	elif impact>1200:hitted(4)
	elif impact>900:hitted(3)
	elif impact>600:hitted(2)
	elif impact>300:hitted()
