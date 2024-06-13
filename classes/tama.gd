class_name DigimonTama extends Node
@onready var sprite:Sprite2D=$Sprite2D
func set_progress(i:float):sprite.material.set("shader_parameter/progress",i)
func _ready():
	await get_tree().create_timer(30).timeout
	var tween=get_tree().create_tween().set_loops(5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite,"scale:y",0.7,0.3)
	tween.chain().tween_property(sprite,"scale:y",1,0.3)
	await tween.finished
	var tween2=get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT_IN)
	tween2.tween_method(set_progress,0,2,1)
