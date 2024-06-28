extends Label
func _ready()->void:
	position.y=-20
	await get_tree().create_timer(0.15).timeout
	var tween=get_tree().create_tween()
	tween.tween_property(self,"position:y",20,0.5)
	await tween.finished
	queue_free()
